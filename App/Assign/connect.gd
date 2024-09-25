extends Control


func _ready() -> void:
	Signals.class_selected.connect(_class_selected)
	Signals.student_selected.connect(_student_selected)


func _class_selected(class_title):
	print("Got it: ", class_title)
	%ClassList.clear()
	%ClassList.add_item(class_title)


func _student_selected(students : Dictionary):
	print("Got students: ", students)
	%StudentList.clear()
	var list : Array = students.keys()
	list.sort()
	for student in list:
		%StudentList.add_item(student, null, false)
