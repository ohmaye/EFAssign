extends Control

# Set global vars
func _ready():
	GlobalVars.general_checkbox = %GeneralCheckBox
	GlobalVars.intensive_checkbox = %IntensiveCheckBox
	
# DEMAND
var survey_scene = preload("res://App/demand/survey.tscn")
var students_scene = preload("res://App/demand/students.tscn")
var by_student_scene = preload("res://App/demand/by_student.tscn")
var by_level_scene = preload("res://App/demand/by_level.tscn")
var by_course_scene = preload("res://App/demand/by_course.tscn")

func _on_demand_id_pressed(id:int):
	var content_container = %DemandContent
	Utilities.remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = survey_scene.instantiate()
		1:
			scene = students_scene.instantiate()
		2:
			scene = by_student_scene.instantiate()
		3:
			scene = by_course_scene.instantiate()
		4:
			scene = by_level_scene.instantiate()
		_:	
			scene = by_course_scene.instantiate()

	scene.call_deferred("render")	
	content_container.add_child(scene)


# ASSIGN
var teacher_preferences_scene = preload("res://App/assign/teacher_preferences.tscn")
var student_preferences_scene = preload("res://App/assign/student_preferences.tscn")
var analyze_scene = preload("res://App/assign/analyze.tscn")
var assign_scene = preload("res://App/assign/assign.tscn")
var reports_scene = preload("res://App/assign/reports.tscn")

func _on_assign_id_pressed(id:int):
	var content_container = %AssignContent
	Utilities.remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = teacher_preferences_scene.instantiate()
		1:
			scene = student_preferences_scene.instantiate()
		2:
			scene = analyze_scene.instantiate()
		3:
			scene = by_course_scene.instantiate()
		4:
			scene = assign_scene.instantiate()
		_:	
			scene = reports_scene.instantiate()

	scene.call_deferred("render")	
	content_container.add_child(scene)


# SUPPLY
var teachers_scene = preload("res://App/Supply/teachers.tscn")
var courses_scene = preload("res://App/Supply/courses.tscn")
var rooms_scene = preload("res://App/Supply/rooms.tscn")
var timeslots_scene = preload("res://App/Supply/timeslots.tscn")

func _on_supply_id_pressed(id:int):
	var content_container = %SupplyContent
	Utilities.remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = teachers_scene.instantiate()
		1:
			scene = courses_scene.instantiate()
		2:
			scene = rooms_scene.instantiate()
		3:
			scene = timeslots_scene.instantiate()
		_:	
			scene = teachers_scene.instantiate()

	scene.call_deferred("render")		
	content_container.add_child(scene)


func _on_add_btn_pressed() -> void:
	print("Add pressed")
	Signals.add_new.emit()

func _on_general_check_box_pressed() -> void:
	Signals.data_changed.emit()

func _on_intensive_check_box_pressed() -> void:
	Signals.data_changed.emit()
