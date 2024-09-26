extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## Button Handlers
##
## Handlers for Home, File, Demand, Assign, and Supply

func _on_home_btn_pressed() -> void:
	pass # Replace with function body.

func _on_file_btn_pressed() -> void:
	pass # Replace with function body.

func _on_demand_btn_pressed() -> void:
	pass # Replace with function body.

func _on_assign_btn_pressed() -> void:
	pass # Replace with function body.

func _on_supply_btn_pressed() -> void:
	pass # Replace with function body.

# Utils

func _change_scene(scene : PackedScene):
	var container = %Content
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)