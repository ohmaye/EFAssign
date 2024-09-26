extends ColorRect

var assign_scene = preload("res://App/assign/Assign/assign.tscn")
var assignments_scene = preload("res://App/assign/Assignments/assignments.tscn")
var timetables_scene = preload("res://App/assign/Timetables/timetables.tscn")
var teacher_preferences_scene = preload("res://App/assign/TeacherPreferences/teacher_preferences.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _change_scene(scene : PackedScene):
	var container = %AssignContent
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)

## ASSIGN TAB
##
## Handlers for Assign, Assignments, Timetables, and Teacher Preferences

func _on_assign_btn_pressed() -> void:
	_change_scene(assign_scene)

func _on_assignments_btn_pressed() -> void:
	_change_scene(assignments_scene)

func _on_timetables_btn_pressed() -> void:
	_change_scene(timetables_scene)

func _on_teacher_preferences_btn_pressed() -> void:
	_change_scene(teacher_preferences_scene)