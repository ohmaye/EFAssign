extends Control

var teachers_scene = preload("res://UI/Supply/teachers.tscn")
var courses_scene = preload("res://UI/Supply/courses.tscn")
var rooms_scene = preload("res://UI/Supply/rooms.tscn")
var timeslots_scene = preload("res://UI/Supply/timeslots.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello")


func _on_supply_id_pressed(id:int):
	var content_container = get_node("%SupplyContent")
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
