extends ColorRect

var survey_scene = preload("res://App/Demand/Survey/Survey.tscn")
var students_scene = preload("res://App/Demand/Students/students.tscn")
var by_student_scene = preload("res://App/Demand/ByStudent/by_student.tscn")
var by_course_scene = preload("res://App/Demand/ByCourse/by_course.tscn")
var by_level_scene = preload("res://App/Demand/ByLevel/by_level.tscn")

func _change_scene(scene : PackedScene):
	var container = %DemandContent
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## DEMAND TAB
##
## Handlers for Survey, Students, By_Student, By_Course, and By_Level

func _on_survey_btn_pressed() -> void:
	_change_scene(survey_scene)

func _on_students_btn_pressed() -> void:
	_change_scene(students_scene)

func _on_by_student_btn_pressed() -> void:
	_change_scene(by_student_scene)

func _on_by_course_btn_pressed() -> void:
	_change_scene(by_course_scene)

func _on_by_level_btn_pressed() -> void:
	_change_scene(by_level_scene)
