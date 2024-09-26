extends ColorRect


var classes_scene = preload("res://App/Supply/Classes/classes.tscn")
var courses_scene = preload("res://App/Supply/Courses/courses.tscn")
var teachers_scene = preload("res://App/Supply/Teachers/teachers.tscn")
var rooms_scene = preload("res://App/Supply/Rooms/rooms.tscn")
var timeslots_scene = preload("res://App/Supply/Timeslots/timeslots.tscn")


func _change_scene(scene : PackedScene):
	var container = %SupplyContent
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## SUPPLY TAB
##
## Handlers for Classes, Courses, Teachers, Rooms, and Timeslots

func _on_classes_btn_pressed() -> void:
	_change_scene(classes_scene)

func _on_courses_btn_pressed() -> void:
	_change_scene(courses_scene)

func _on_teachers_btn_pressed() -> void:
	_change_scene(teachers_scene)

func _on_rooms_btn_pressed() -> void:
	_change_scene(rooms_scene)

func _on_timeslots_btn_pressed() -> void:
	_change_scene(timeslots_scene)
