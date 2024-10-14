extends PopupMenu

var classes : Array

var current_student = {}
var current_assignment = {}

# EO FIX ME: If they want to filter by program, then we need to add a program to the classes table
# (for_program) and then filter by that.
const sql_classes = """
		SELECT cv.class_id, cv.title, cv.'when', cv.who, cv.for_program FROM classes_view cv
		WHERE timeslot_active = 1 AND timeslot_id = '%s'
		ORDER BY cv.title, cv.weekday_sort_key, cv.'when'
"""

func _ready():
	index_pressed.connect(_on_assignment_selected)


func load_and_render(student, student_assignment, timeslot):
	current_student = student
	current_assignment = student_assignment
	# print("Loaded classes: ", classes)
	clear()

	# Add the clear assignment option at the top
	add_item("Clear Assignment")

	# Add the classes available
	classes = AppDB.db_get(sql_classes % timeslot['timeslot_id'])
	for class_ in classes:
		var time = class_.get('when') if class_.get('when') else "?"
		var class_title = class_.get('title') if class_.get('title') else "?"
		var who = class_.get('who') if class_.get('who') else "?"
		# Combine the time, class title, and who
		var text = "%s - %s - %s" % [time, class_title, who]
		add_item(str(text))


func _on_assignment_selected(index):

	# If asked to clear an empty assignment, then do nothing
	if index == 0 and not current_assignment:
		print("No assignment to clear")
		return

	# If asked to clear an existing assignment, then do it
	if index == 0 and current_assignment:
		print("Clearing assignment")
		_delete_current_assignment()
		Signals.emit_signal("data_changed")
		return

	# Get the selected class (the index is shifted because of the "Clear Assignment" option)
	var selected_class = classes[index - 1]
	printt("id_pressed -> Class ID: ", index, selected_class.get('title'))
	printt("Metadata: ", current_assignment)

	# If the new class is equal to the current class, do nothing
	if current_assignment and selected_class.get('class_id') == current_assignment.get('class_id'):
		print("Same class, do nothing")
		return

	# If there is an assignment, delete it
	if current_assignment:
		print("Clearing assignment")
		_delete_current_assignment()

	# Insert the new assignment
	var class_id = selected_class.get('class_id')
	var student_id = current_student.get('student_id')
	var sql = "INSERT INTO assignments (assignment_id, student_id, class_id) VALUES ('%s','%s', '%s')" 
	var sql_stmt = sql % [Utils.uuid.v4(), student_id, class_id]
	print("Query: ", sql_stmt)
	var result = AppDB.db_run(sql_stmt)
	if !result:
		%StatusMsg.text = "Status: There was a problem assigning students to class."
		%StatusMsg.text += AppDB.db.error_message
		return

	Signals.emit_signal("data_changed")

func _delete_current_assignment():
	var sql = "DELETE FROM assignments WHERE assignment_id = '%s'"
	var sql_stmt = sql % current_assignment['assignment_id']
	AppDB.db_run(sql_stmt)