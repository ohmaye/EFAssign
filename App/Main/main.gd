extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set global vars
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
			scene.call_deferred("render")		
		1:
			scene = students_scene.instantiate()
			print("Demand")
			scene.call_deferred("render")		
		2:
			scene = by_student_scene.instantiate()
			scene.call_deferred("render")		
		3:
			scene = by_course_scene.instantiate()
			scene.call_deferred("render")		
		4:
			scene = by_level_scene.instantiate()
			scene.call_deferred("render")		
		_:	
			scene = by_course_scene.instantiate()
			scene.call_deferred("render")		

	content_container.add_child(scene)


# SUPPLY
var teachers_scene = preload("res://App/Supply/teachers.tscn")
var courses_scene = preload("res://App/Supply/courses.tscn")
var rooms_scene = preload("res://App/Supply/rooms.tscn")
var timeslots_scene = preload("res://App/Supply/timeslots.tscn")

func _on_supply_id_pressed(id:int):
	var content_container = %SupplyContent
	remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = teachers_scene.instantiate()
			scene.call_deferred("render")		
		1:
			scene = courses_scene.instantiate()
			scene.call_deferred("render")		
		2:
			scene = rooms_scene.instantiate()
			scene.call_deferred("render")		
		3:
			scene = timeslots_scene.instantiate()
			scene.call_deferred("render")		
		_:	
			scene = teachers_scene.instantiate()
			scene.call_deferred("render")		

	content_container.add_child(scene)

func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		child.queue_free()  # This will delete the child from memory


func _on_add_btn_pressed() -> void:
	print("Add pressed")
	Signals.add_new.emit()

func _on_general_check_box_pressed() -> void:
	Signals.data_changed.emit()

func _on_intensive_check_box_pressed() -> void:
	Signals.data_changed.emit()
