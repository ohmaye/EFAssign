extends Control

# Set global vars
func _ready():
	# Utilities.save_user_prefs()
	# Utilities.load_user_prefs()
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


## UTILS
##
## Signals and Scene mgmt

func _on_add_btn_pressed() -> void:
	Signals.add_new.emit()

func _on_check_box_pressed() -> void:
	Signals.data_changed.emit()

func _change_scene(content_container, scene : PackedScene):
	Utilities.remove_all_children(content_container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	content_container.add_child(scene_node)


## FILE TAB
##
## Handlers for Open, New, Save, Save As, Load Survey, and Quit

func _on_open_btn_pressed() -> void:
	var scene = preload("res://App/demand/survey.tscn")
	_change_scene(%FileContent, scene)

func _on_new_btn_pressed() -> void:
	var scene = preload("res://App/demand/students.tscn")
	_change_scene(%FileContent, scene)

func _on_save_btn_pressed() -> void:
	var scene = preload("res://App/demand/by_student.tscn")
	_change_scene(%FileContent, scene)

func _on_save_as_btn_pressed() -> void:
	var scene = preload("res://App/demand/by_level.tscn")
	_change_scene(%FileContent, scene)

func _on_load_survey_btn_pressed() -> void:
	var scene = preload("res://App/file/load_survey.tscn")
	%FileDialog.visible = true
	%FileDialog.file_selected.connect(_file_selected)
	_change_scene(%FileContent, scene)

func _file_selected(path : String):
	var survey : Array
	var file = FileAccess.open(path, FileAccess.READ)
	print("File: ", file)

	if file == null:
		print("Couldn't open the file")
		return

	while not file.eof_reached():
		var csvRow = file.get_csv_line(",")
		var row = []
		for field in csvRow:
			row.append(field)
		survey.append(row)
	print("Survey: ", survey)

func _on_quit_btn_pressed() -> void:
	print("Calling quit")
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


## DEMAND TAB
##
## Handlers for Load Survey, Students, By_Student, By_Course, and By_Level

func _on_survey_btn_pressed() -> void:
	var scene = preload("res://App/demand/survey.tscn")
	_change_scene(%DemandContent, scene)

func _on_students_btn_pressed() -> void:
	var scene = preload("res://App/demand/students.tscn")
	_change_scene(%DemandContent, scene)

func _on_by_student_btn_pressed() -> void:
	var scene = preload("res://App/demand/by_student.tscn")
	_change_scene(%DemandContent, scene)

func _on_by_course_btn_pressed() -> void:
	var scene = preload("res://App/demand/by_course.tscn")
	_change_scene(%DemandContent, scene)

func _on_by_level_btn_pressed() -> void:
	var scene = preload("res://App/demand/by_level.tscn")
	_change_scene(%DemandContent, scene)


## ASSIGN TAB
##
## Handlers for Assign, Assignments, Timetables, and Teacher Preferences

func _on_assign_btn_pressed() -> void:
	var scene = preload("res://App/assign/assign.tscn")
	_change_scene(%AssignContent, scene)

func _on_assignments_btn_pressed() -> void:
	var scene = preload("res://App/assign/assignments.tscn")
	_change_scene(%AssignContent, scene)

func _on_timetables_btn_pressed() -> void:
	var scene = preload("res://App/assign/timetables.tscn")
	_change_scene(%AssignContent, scene)

func _on_teacher_preferences_btn_pressed() -> void:
	var scene = preload("res://App/assign/teacher_preferences.tscn")
	_change_scene(%AssignContent, scene)



## SUPPLY TAB
##
## Handlers for Classes, Courses, Teachers, Rooms, and Timeslots

func _on_classes_btn_pressed() -> void:
	var scene = preload("res://App/Supply/classes.tscn")
	_change_scene(%SupplyContent, scene)

func _on_courses_btn_pressed() -> void:
	var scene = preload("res://App/Supply/courses.tscn")
	_change_scene(%SupplyContent, scene)

func _on_teachers_btn_pressed() -> void:
	var scene = preload("res://App/Supply/teachers.tscn")
	_change_scene(%SupplyContent, scene)

func _on_rooms_btn_pressed() -> void:
	var scene = preload("res://App/Supply/rooms.tscn")
	_change_scene(%SupplyContent, scene)

func _on_timeslots_btn_pressed() -> void:
	var scene = preload("res://App/Supply/timeslots.tscn")
	_change_scene(%SupplyContent, scene)






