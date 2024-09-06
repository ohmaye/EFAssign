extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_supply_id_pressed(id:int):
	print("Supply ID: ", id)
