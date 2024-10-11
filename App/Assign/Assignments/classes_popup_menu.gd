extends PopupMenu

var classes : Array

var current_assignment = {}

const sql_classes = """
		SELECT cv.class_id, cv.title, cv.'when', cv.who, cv.for_program FROM classes_view cv
		WHERE timeslot_active = 1
		ORDER BY cv.title, cv.weekday_sort_key, cv.'when'
"""

func _ready():
	index_pressed.connect(_on_assignment_selected)


func load_and_render(item):
	current_assignment = item
	classes = AppDB.db_get(sql_classes)
	# print("Loaded classes: ", classes)
	clear()

	add_item("Clear Assignment")
	for cls in classes:
		var class_title = cls.get('title') if cls.get('title') else "?"
		var time = cls.get('when') if cls.get('when') else "?"
		var who = cls.get('who') if cls.get('who') else "?"
		var text = "%s - %s - %s" % [time, class_title, who]
		add_item(str(text))


func _on_assignment_selected(index):
	printt("id_pressed -> Class ID: ", index, classes[index - 1].get('title'))
	printt("Metadata: ", current_assignment)

	# If asked to clear an empty assignment, then do nothing
	if index == 0 and not current_assignment:
		return
	
	# If the new assignment is equal to the current assignment, do nothing

	# If there is an assignment, delete it
	if current_assignment:
		print("Clearing assignment")
		_delete_current_assignment()

	# Insert the new assignment
	# var class_id = classes[index - 1].get('class_id')
	# var student_id = 
	# var sql = "INSERT INTO assignments (assignment_id, student_id, class_id) VALUES ('%s','%s', '%s')" 
	# var sql_stmt = sql % [Utils.uuid.v4(), student_id, class_id]
	# # print("Query: ", sql)
	# var result = AppDB.db_run(sql_stmt)
	# if !result:
	# 	%StatusMsg.text = "Status: There was a problem assigning students to class."
	# 	%StatusMsg.text += AppDB.db.error_message
	# 	return

	# Signals.emit_signal("data_changed")

func _delete_current_assignment():
	var sql = "DELETE FROM assignments WHERE assignment_id = '%s'"
	var sql_stmt = sql % current_assignment['assignment_id']
	AppDB.db_run(sql_stmt)
