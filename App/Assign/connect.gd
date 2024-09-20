extends Control


func _ready() -> void:
	var label = %Label.duplicate()
	label.text = "Student 1"
	%StudentList.add_child(label)
	label = %Label.duplicate()
	label.text = "Class 1"
	%ClassList.add_child(label)


