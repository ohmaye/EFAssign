extends Control

var home_scene = preload("res://App/Home/home.tscn")
var file_scene = preload("res://App/File/file.tscn")
var demand_scene = preload("res://App/Demand/demand.tscn")
var assign_scene = preload("res://App/Assign/assign.tscn")
var supply_scene = preload("res://App/Supply/supply.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Notification: Will close app")
		Utils.save_user_prefs()


## Global filters and buttons
##
## Signals and Scene mgmt

func _on_add_btn_pressed() -> void:
	Signals.add_new.emit()

func _on_check_box_pressed() -> void:
	Signals.data_changed.emit()

	
## Button Handlers
##
## Handlers for Home, File, Demand, Assign, and Supply

func _on_home_btn_pressed() -> void:
	Utils.change_scene(%Content, home_scene)

func _on_file_btn_pressed() -> void:
	Utils.change_scene(%Content, file_scene)

func _on_demand_btn_pressed() -> void:
	Utils.change_scene(%Content, demand_scene)

func _on_assign_btn_pressed() -> void:
	Utils.change_scene(%Content, assign_scene)

func _on_supply_btn_pressed() -> void:
	Utils.change_scene(%Content, supply_scene)
