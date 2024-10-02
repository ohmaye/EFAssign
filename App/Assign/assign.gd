extends ColorRect

@onready  var container = %AssignContent

var assign_scene = preload("res://App/Assign/Assign/assign.tscn")
var assignments_scene = preload("res://App/Assign/Assignments/assignments.tscn")
var timetables_scene = preload("res://App/Assign/Timetables/timetables.tscn")
var teacher_preferences_scene = preload("res://App/Assign/TeacherPreferences/teacher_preferences.tscn")


## ASSIGN TAB
##
## Handlers for Assign, Assignments, Timetables, and Teacher Preferences

func _on_assign_btn_pressed() -> void:
	Utils.change_scene(container, assign_scene)

func _on_assignments_btn_pressed() -> void:
	Utils.change_scene(container, assignments_scene)

func _on_timetables_btn_pressed() -> void:
	Utils.change_scene(container, timetables_scene)

func _on_teacher_preferences_btn_pressed() -> void:
	Utils.change_scene(container, teacher_preferences_scene)