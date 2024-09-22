extends Control


func _ready() -> void:
	Signals.class_selected.connect(_class_selected)
	Signals.student_selected.connect(_student_selected)


func _class_selected(class_title):
	print("Got it: ", class_title)
	%ClassList.clear()
	var label = %Label.duplicate()
	label.text = class_title
	%ClassList.add_child(label)


func _student_selected(students):
	print("Got students: ", students)
	%StudentList.clear()
	for student in students:
		%StudentList.add_item(student.get_text(0), null, false)
