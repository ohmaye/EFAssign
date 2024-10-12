extends Tree

const COLUMN_NAMES  = Constants.DEMAND_SHOW_COLUMNS

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

var button_icon = preload("res://UI/Icons/expanded.svg")

@onready var popup_menu : PopupMenu = %ClassesPopupMenu

var root : TreeItem
var active_timeslots : Array[TimeSlot] = []

func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)

	button_clicked.connect(_on_assignment_btn_pressed)
	
	# Create the root item
	root = create_item()

	_load_data_and_render()
	

func _load_data_and_render():
	# Set Tree format and initialize headers
	_set_format_and_headers()

	Utils.free_all_treeitems(root)

	# Create a row for each student
	var students = AppDB.db_get(sql)
	for student in students:
		_create_student_row(student, root)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % students.size()


func _set_format_and_headers():
	active_timeslots = _get_active_timeslots()

	# Get weekday + start_time in a format suitable for the headers
	var ts_headers = []
	for timeslot in active_timeslots:
		ts_headers.append(timeslot.weekday + " " + timeslot.start_time)
		
	# Combine headers for student choices with active ts_headers
	var headers = Utils.filtered_columns(COLUMN_NAMES) + ts_headers

	# Set up the # of columns & titles
	set_columns(headers.size())
	for header in headers:
		set_column_title(headers.find(header), header)
		# set_column_custom_minimum_width(headers.find(header), 100)

	return


func _create_student_row(student, parent_node):
	# First sep: Fill in the student & choice data (left part)
	var _row = parent_node.create_child()
	var _columns = Utils.filtered_columns(COLUMN_NAMES)

	# Store the student data as metadata (0)
	_row.set_metadata(0, student)

	for column in _columns:
		var index = _columns.find(column)
		var txt = student[column]
		_row.set_text(index, str(txt) if txt else "-") 
		_row.set_text_alignment(index, HORIZONTAL_ALIGNMENT_CENTER)

	# Second sep: Fill in the assignment data (right part)
	for timeslot in active_timeslots:
		var index = active_timeslots.find(timeslot)
		var timeslot_index = _columns.size() + index 
		
		# If student has an assignment in this timeslot, show the class title and store it as metadata
		var student_assignment = _get_student_assignment_in_timeslot(student['student_id'], timeslot)
		if student_assignment:
			_row.set_text(timeslot_index, student_assignment['title'])
			_row.set_text_alignment(timeslot_index, HORIZONTAL_ALIGNMENT_CENTER)
			_row.set_custom_bg_color(timeslot_index, "#91E2A4")
			_row.set_metadata(timeslot_index, student_assignment)
		else:
			_row.set_custom_bg_color(timeslot_index, "#A3FFD8")

		_row.add_button(timeslot_index, button_icon)
	


func _on_assignment_btn_pressed(item: Object, _column: int, _id: , _mouse_button_index: int):
	# printt("Button clicked: ", "Student:", item.get_metadata(0), "Assignment: ", item.get_metadata(1)	)
	popup_menu.visible = true
	popup_menu.position = get_global_mouse_position() - Vector2(400, 0) # EO FIXME: Magic number
	# Pass the metadata to the popup menu, which is the student's assignment
	printt("Metadata 0: ", item.get_metadata(0))
	printt("Metadata 1", item.get_metadata(_column))
	popup_menu.load_and_render(item.get_metadata(0), item.get_metadata(1))


func _on_data_changed():
	_load_data_and_render()


const sql_assignment = """
		SELECT a.assignment_id, a.student_id, a.class_id, c.title FROM assignments a
		JOIN classes AS c USING (class_id)
		JOIN students AS s USING (student_id)
		JOIN timeslots AS ts ON c.timeslot_id = ts.timeslot_id
		WHERE s.student_id = '%s' AND ts.timeslot_id = '%s';
"""
func _get_student_assignment_in_timeslot(student_id, timeslot : TimeSlot):
	# printt("Student ID: ", student_id, "Timeslot: ", timeslot)
	var sql_stmt = sql_assignment % [student_id, timeslot.timeslot_id]
	var result = AppDB.db_get(sql_stmt)
	if result.size() != 0:
		printt("Assignment found for student: ", student_id, "Timeslot: ", timeslot.timeslot_id)

	return null if result.size() == 0 else result[0]


func _get_active_timeslots() -> Array[TimeSlot]:
	var sql_active_weekdays = """
		SELECT timeslot_id, t.weekday, start_time, end_time, sort_key FROM timeslots AS t
		JOIN weekdays AS w ON w.weekday = t.weekday
		WHERE t.active = 1
		ORDER BY sort_key
	"""

	var result : Array[TimeSlot]= []
	for timeslot in AppDB.db_get(sql_active_weekdays):
		var ts = TimeSlot.new(timeslot)
		result.append(ts)

	return result
