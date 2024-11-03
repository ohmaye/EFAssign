extends Node

signal filters_changed
signal data_changed
signal add_new

signal class_selected
signal student_selected

signal assignment_selected

signal total_changed(total)

signal zoom_in()
signal zoom_out()

func emit_filters_changed():
	emit_signal("filters_changed")

func emit_data_changed():
	emit_signal("data_changed")

func emit_add_new():
	emit_signal("add_new")

func emit_class_selected(class_):
	emit_signal("class_selected", class_)

func emit_student_selected(student):
	emit_signal("student_selected", student)

func emit_assignment_selected(assignment):
	emit_signal("assignment_selected", assignment)

func emit_total_changed(total):
	emit_signal("total_changed", total)

func emit_zoom_in():
	emit_signal("zoom_in")

func emit_zoom_out():
	emit_signal("zoom_out")