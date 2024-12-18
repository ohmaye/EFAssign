extends Control

var selected_students = []
var selected_class = {}

func _ready() -> void:
	Signals.class_selected.connect(_class_selected)
	Signals.student_selected.connect(_student_selected)


func _class_selected(_class):
	selected_class = _class
	%ClassLbl.text = _class["title"] if _class["title"] else _class["class_id"]


func _student_selected(students : Dictionary):
	# Store it for assignments
	selected_students = students
	%StudentList.clear()
	var list : Array = students.keys()
	list.sort()
	for student in list:
		%StudentList.add_item(student, null, false)

	var total = "(" + str(list.size()) + ")"
	%TotalSelectedLbl.text = total
	%TotalToAssignLbl.text = total


func _on_assign_btn_pressed() -> void:
	if selected_class == {} or selected_students.size() == 0:
		%StatusMsg.text = "Status: Please select a class and students to assign."
		return
		
	for student in selected_students.keys():
		var student_id = selected_students[student]["student_id"]
		var class_id = selected_class["class_id"]
		var sql = "INSERT INTO assignments (assignment_id, student_id, class_id, uploaded) VALUES ('%s','%s', '%s', 0)" 
		var sql_stmt = sql % [Utils.uuid.v4(), student_id, class_id]
		
		var result = AppDB.db_run(sql_stmt)
		if !result:
			%StatusMsg.text = "Status: There was a problem assigning students to class."
			%StatusMsg.text += AppDB.db.error_message
			return

	%StatusMsg.text = "Status: Successfully assigned students to class."
	Signals.emit_data_changed()

# EO FIXME: If an assignment at the same time exists, need to delete it first.