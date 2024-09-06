extends Control

var teachers_scene = preload("res://UI/Supply/teachers.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_supply_id_pressed(id:int):
	var content_container = $Content
	print("Supply ID: ", id)
	var scene = teachers_scene.instantiate()
	content_container.add_child(scene)
