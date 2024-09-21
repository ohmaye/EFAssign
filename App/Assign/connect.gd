extends Control


func _ready() -> void:
	var label = %Label.duplicate()
	label.text = "Student 1"
	%StudentList.add_child(label)
	label = %Label.duplicate()
	label.text = "Class 1"
	%ClassList.add_child(label)
	Signals.class_selected.connect(_class_selected)
	Signals.student_selected.connect(_student_selected)


func _class_selected(class_title):
	print("Got it: ", class_title)
	%ClassList.clear()
	var label = %Label.duplicate()
	label.text = class_title
	%ClassList.add_child(label)


func _student_selected(students):
	print("Got it: ", students)
	%StudentList.clear()
	for student in students:
		var label = %Label.duplicate()
		label.text = student.get_text(0)
		%StudentList.add_child(label)