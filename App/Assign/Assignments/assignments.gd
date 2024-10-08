extends Tree

const COLUMN_NAMES  = Constants.DEMAND_SHOW_COLUMNS
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

var button_icon = preload("res://UI/Icons/expanded.svg")

const sql_assignment = """
		SELECT c.title FROM assignments
		JOIN classes AS c USING (class_id)
		JOIN students AS s USING (student_id)
		JOIN timeslots AS ts ON c.timeslot_id = ts.timeslot_id
		WHERE s.student_id = '%s' AND ts.timeslot_id = '%s';
"""



var root : TreeItem
var active_weekdays = []
var weekdays = []
var popup_menu : PopupMenu

func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)

	button_clicked.connect(_on_assignment_btn_pressed)
	
	# Create the root item
	root = create_item()
	popup_menu = %ClassesPopupMenu

	_load_data_and_render()
	

func _on_assignment_btn_pressed(item: Object, column: int, id: , mouse_button_index: int):
	printt("Button clicked: ", item,"Col:", column, id, mouse_button_index)
	popup_menu.visible = true
	popup_menu.position = get_global_mouse_position() - Vector2(200, 0)
	popup_menu.load_and_render()


func _set_format_and_headers() -> Array:
	active_weekdays = _get_active_timeslots()

	# Get weekday + start_time in a format suitable for the headers
	weekdays = []
	for record in active_weekdays:
		weekdays.append(record['weekday'] + " " + record['start_time'])
		
	var headers = Utils.filtered_columns(COLUMN_NAMES) + weekdays

	# Set up the columns & titles
	set_columns(headers.size())
	for header in headers:
		set_column_title(headers.find(header), header)
		# set_column_custom_minimum_width(headers.find(header), 100)

	return headers


func _on_data_changed():
	_load_data_and_render()


func _load_data_and_render():
	_set_format_and_headers()

	Utils.free_all_treeitems(root)

	var students = AppDB.db_get(sql)
	
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % students.size()

	for student in students:
		_create_student_row(student, root)


func _create_student_row(student, parent):
	var item = parent.create_child()
	for column in Utils.filtered_columns(COLUMN_NAMES):
		var index = Utils.filtered_columns(COLUMN_NAMES).find(column)
		var txt = student[column]
		item.set_text(index, str(txt) if txt else "-") 
		item.set_text_alignment(index, HORIZONTAL_ALIGNMENT_CENTER)

	for weekday in active_weekdays:
		var index = active_weekdays.find(weekday)
		var adjusted_index = index + Utils.filtered_columns(COLUMN_NAMES).size()
		item.set_text(adjusted_index, _get_student_assignment_in_timeslot(student['student_id'], weekday))
		item.set_text_alignment(adjusted_index, HORIZONTAL_ALIGNMENT_CENTER)
		item.add_button(adjusted_index, button_icon)
		if item.get_text(adjusted_index) != "-":
			item.set_custom_bg_color(adjusted_index, "#91E2A4")
		else:
			item.set_custom_bg_color(adjusted_index, "#A3FFD8")


func _get_student_assignment_in_timeslot(student_id, weekday):
	var sql_stmt = sql_assignment % [student_id, weekday['timeslot_id']]
	var result = AppDB.db_get(sql_stmt)
	return result[0]['title'] if result.size() > 0 else "-"


func _get_active_timeslots() -> Array:
	var sql_active_weekdays = """
		SELECT timeslot_id, t.weekday, start_time, end_time, sort_key FROM timeslots AS t
		JOIN weekdays AS w ON w.weekday = t.weekday
		WHERE t.active = 1
		ORDER BY sort_key
	"""
	return AppDB.db_get(sql_active_weekdays)
