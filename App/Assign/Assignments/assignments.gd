extends Tree

@onready var grid : GridContainer = %GridContainer

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

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

func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)
	
	# Create the root item
	root = create_item()

	_load_data_and_render()


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
	var item = create_item(parent)
	for index in range(student.size()):
		var txt = student[student.keys()[index]]
		item.set_text(index, str(txt) if txt else "") 
		item.set_text_alignment(index, HORIZONTAL_ALIGNMENT_CENTER)

	for index in range(active_weekdays.size()):
		var adjusted_index = index + Utils.filtered_columns(COLUMN_NAMES).size()
		item.set_text(adjusted_index, _get_student_assignment_in_timeslot(student['student_id'], index))
		item.set_text_alignment(adjusted_index, HORIZONTAL_ALIGNMENT_CENTER)


func _get_student_assignment_in_timeslot(student_id, timeslot_index):
	var sql_stmt = sql_assignment % [student_id, active_weekdays[timeslot_index]['timeslot_id']]
	var result = AppDB.db_get(sql_stmt)
	return result[0]['title'] if result.size() > 0 else ""


func _get_active_timeslots() -> Array:
	var sql_active_weekdays = """
		SELECT timeslot_id, t.weekday, start_time, end_time, sort_key FROM timeslots AS t
		JOIN weekdays AS w ON w.weekday = t.weekday
		WHERE t.active = 1
		ORDER BY sort_key
	"""
	return AppDB.db_get(sql_active_weekdays)
