extends ColorRect

@onready var container = %DemandContent

var students_scene = preload("res://App/Demand/Students/students.tscn")
var by_student_scene = preload("res://App/Demand/ByStudent/by_student.tscn")
var by_course_scene = preload("res://App/Demand/ByCourse/by_course.tscn")
var by_level_scene = preload("res://App/Demand/ByLevel/by_level.tscn")


## DEMAND TAB
##
## Handlers for Survey, Students, By_Student, By_Course, and By_Level

func _on_students_btn_pressed() -> void:
	Utils.change_scene(container, students_scene)

func _on_by_student_btn_pressed() -> void:
	Utils.change_scene(container, by_student_scene)

func _on_by_course_btn_pressed() -> void:
	Utils.change_scene(container, by_course_scene)

func _on_by_level_btn_pressed() -> void:
	Utils.change_scene(container, by_level_scene)
