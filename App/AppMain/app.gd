extends Control

var demand_scene = preload("res://App/Demand/demand.tscn")
var assign_scene = preload("res://App/Assign/assign.tscn")
var supply_scene = preload("res://App/Supply/supply.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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


## Button Handlers
##
## Handlers for Home, File, Demand, Assign, and Supply

func _on_home_btn_pressed() -> void:
	print("Home")

func _on_file_btn_pressed() -> void:
	print("File")

func _on_demand_btn_pressed() -> void:
	_change_scene(demand_scene)

func _on_assign_btn_pressed() -> void:
	_change_scene(assign_scene)

func _on_supply_btn_pressed() -> void:
	print("Supply")
	_change_scene(supply_scene)

# Utils

func _change_scene(scene : PackedScene):
	var container = %Content
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)