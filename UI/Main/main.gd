extends Control

# DEMAND
var students_scene = preload("res://UI/demand/students.tscn")
var survey_scene = preload("res://UI/demand/survey.tscn")

func _on_demand_id_pressed(id:int):
	var content_container = %DemandContent
	remove_all_children(content_container)
	var scene
	match id:
		0:
			scene = survey_scene.instantiate()
		1:
			scene = students_scene.instantiate()
		2:
			scene = rooms_scene.instantiate()
		3:
			scene = timeslots_scene.instantiate()
		_:	
			scene = students_scene.instantiate()

	content_container.add_child(scene)


# SUPPLY
var teachers_scene = preload("res://UI/Supply/teachers.tscn")
var courses_scene = preload("res://UI/Supply/courses.tscn")
var rooms_scene = preload("res://UI/Supply/rooms.tscn")
var timeslots_scene = preload("res://UI/Supply/timeslots.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello")


func _on_supply_id_pressed(id:int):
	var content_container = %SupplyContent
	remove_all_children(content_container)
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

	content_container.add_child(scene)

func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		child.queue_free()  # This will delete the child from memory