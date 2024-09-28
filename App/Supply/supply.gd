extends ColorRect

@onready var container = %SupplyContent

var classes_scene = preload("res://App/Supply/Classes/classes.tscn")
var courses_scene = preload("res://App/Supply/Courses/courses.tscn")
var teachers_scene = preload("res://App/Supply/Teachers/teachers.tscn")
var rooms_scene = preload("res://App/Supply/Rooms/rooms.tscn")
var timeslots_scene = preload("res://App/Supply/Timeslots/timeslots.tscn")


## SUPPLY TAB
##
## Handlers for Classes, Courses, Teachers, Rooms, and Timeslots

func _on_classes_btn_pressed() -> void:
	Utils.change_scene(container, classes_scene)

func _on_courses_btn_pressed() -> void:
	Utils.change_scene(container, courses_scene)

func _on_teachers_btn_pressed() -> void:
	Utils.change_scene(container, teachers_scene)

func _on_rooms_btn_pressed() -> void:
	Utils.change_scene(container, rooms_scene)

func _on_timeslots_btn_pressed() -> void:
	Utils.change_scene(container, timeslots_scene)


func _on_add_btn_pressed() -> void:
	print("Add new")
	Signals.add_new.emit()
