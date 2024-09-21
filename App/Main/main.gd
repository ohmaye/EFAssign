extends Control

# Set global vars
func _ready():
	GlobalVars.general_checkbox = %GeneralCheckBox
	GlobalVars.intensive_checkbox = %IntensiveCheckBox
	GlobalVars.m1_checkbox = %Mon1
	GlobalVars.m2_checkbox = %Mon2
	GlobalVars.m3_checkbox = %Mon3
	GlobalVars.w1_checkbox = %Wed1
	GlobalVars.w2_checkbox = %Wed2
	GlobalVars.w3_checkbox = %Wed3
	GlobalVars.w4_checkbox = %Wed4
	GlobalVars.w5_checkbox = %Wed5
	# $FileDialog.visible = false
	# Connect DEMAND buttons to scenes
	%SurveyBtn.pressed.connect(_on_demand_id_pressed.bind(0))
	%StudentsBtn.pressed.connect(_on_demand_id_pressed.bind(1))
	%ByStudentBtn.pressed.connect(_on_demand_id_pressed.bind(2))
	%ByCourseBtn.pressed.connect(_on_demand_id_pressed.bind(3))
	%ByLevelBtn.pressed.connect(_on_demand_id_pressed.bind(4))
	# Connect ASSIGN buttons to scenes
	%AssignBtn.pressed.connect(_on_assign_id_pressed.bind(0))
	%AssignmentsBtn.pressed.connect(_on_assign_id_pressed.bind(1))
	%TimetablesBtn.pressed.connect(_on_assign_id_pressed.bind(2))
	%TeacherPreferencesBtn.pressed.connect(_on_assign_id_pressed.bind(3))
	# Connect SUPPLY buttons to scenes
	%ClassesBtn.pressed.connect(_on_supply_id_pressed.bind(0))
	%TeachersBtn.pressed.connect(_on_supply_id_pressed.bind(1))
	%CoursesBtn.pressed.connect(_on_supply_id_pressed.bind(2))
	%RoomsBtn.pressed.connect(_on_supply_id_pressed.bind(3))
	%TimeslotsBtn.pressed.connect(_on_supply_id_pressed.bind(4))

	
# DEMAND
var survey_scene = preload("res://App/demand/survey.tscn")
var students_scene = preload("res://App/demand/students.tscn")
var by_student_scene = preload("res://App/demand/by_student.tscn")
var by_level_scene = preload("res://App/demand/by_level.tscn")
var by_course_scene = preload("res://App/demand/by_course.tscn")

func _on_demand_id_pressed(id:int):
	print("Demand ID: ", id)
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

	scene.call_deferred("render")	
	content_container.add_child(scene)


# ASSIGN
var assign_scene = preload("res://App/assign/assign.tscn")
var assignments_scene = preload("res://App/assign/assignments.tscn")
var timetables_scene = preload("res://App/assign/timetables.tscn")
var teacher_preferences_scene = preload("res://App/assign/teacher_preferences.tscn")

func _on_assign_id_pressed(id:int):
	var content_container = %AssignContent
	Utilities.remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = assign_scene.instantiate()
		1:
			scene = assignments_scene.instantiate()
		2:
			scene = timetables_scene.instantiate()
		3:
			scene = teacher_preferences_scene.instantiate()

	scene.call_deferred("render")	
	content_container.add_child(scene)


# SUPPLY
var classes_scene = preload("res://App/Supply/classes.tscn")
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
			scene = classes_scene.instantiate()
		1:
			scene = teachers_scene.instantiate()
		2:
			scene = courses_scene.instantiate()
		3:
			scene = rooms_scene.instantiate()
		4:
			scene = timeslots_scene.instantiate()

	scene.call_deferred("render")		
	content_container.add_child(scene)


func _on_add_btn_pressed() -> void:
	Signals.add_new.emit()

func _on_check_box_pressed() -> void:
	Signals.data_changed.emit()
