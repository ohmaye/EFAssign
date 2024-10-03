extends Control

var home_scene = preload("res://App/Home/home.tscn")
var survey_scene = preload("res://App/Survey/survey.tscn")
var demand_scene = preload("res://App/Demand/demand.tscn")
var assign_scene = preload("res://App/Assign/assign.tscn")
var supply_scene = preload("res://App/Supply/supply.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_global_filters()

	# By default, set to Home
	_toggle_tabs_off()
	%HomeBtn.button_pressed = true
	Utils.change_scene(%Content, home_scene)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Notification: Will close app")
		Utils.save_user_prefs()


## Button Handlers
##
## Handlers for Home, File, Demand, Assign, and Supply

func _on_home_btn_pressed() -> void:
	_toggle_tabs_off()
	%HomeBtn.button_pressed = true
	Utils.change_scene(%Content, home_scene)


func _on_survey_btn_pressed() -> void:
	_toggle_tabs_off()
	%SurveyBtn.button_pressed = true
	Utils.change_scene(%Content, survey_scene)


func _on_demand_btn_pressed() -> void:
	_toggle_tabs_off()
	%DemandBtn.button_pressed = true
	Utils.change_scene(%Content, demand_scene)


func _on_assign_btn_pressed() -> void:
	_toggle_tabs_off()
	%AssignBtn.button_pressed = true
	Utils.change_scene(%Content, assign_scene)


func _on_supply_btn_pressed() -> void:
	_toggle_tabs_off()
	%SupplyBtn.button_pressed = true
	Utils.change_scene(%Content, supply_scene)


func _toggle_tabs_off() -> void:
	%HomeBtn.button_pressed = false
	%SurveyBtn.button_pressed = false
	%DemandBtn.button_pressed = false
	%AssignBtn.button_pressed = false
	%SupplyBtn.button_pressed = false


## Global filters and buttons
##
## Signals and Scene mgmt

func _on_add_btn_pressed() -> void:
	Signals.add_new.emit()

func _on_check_box_pressed() -> void:
	print("Pressed checkbox: ")
	_update_global_filters()
	Signals.filters_changed.emit()
	Signals.data_changed.emit()


func _update_global_filters():
	var sql_program = "UPDATE meta_filters SET active = %d WHERE category = 'program' AND name = '%s'"
	GlobalVars.show_general = %GeneralCheckBox.button_pressed
	AppDB.db.query(sql_program % [1 if GlobalVars.show_general else 0, "General"])
	GlobalVars.show_intensive = %IntensiveCheckBox.button_pressed
	AppDB.db.query(sql_program % [1 if GlobalVars.show_intensive else 0, "Intensive"])
	GlobalVars.show_m1 = %Mon1.button_pressed
	GlobalVars.show_m2 = %Mon2.button_pressed
	GlobalVars.show_m3 = %Mon3.button_pressed
	GlobalVars.show_w1 = %Wed1.button_pressed
	GlobalVars.show_w2 = %Wed2.button_pressed
	GlobalVars.show_w3 = %Wed3.button_pressed
	GlobalVars.show_w4 = %Wed4.button_pressed
	GlobalVars.show_w5 = %Wed5.button_pressed
	var columns = Constants.DEMAND_COLUMN_NAMES
	printt("Filters: ", columns)
	printt("Filtered:", Utils.filtered_columns(columns))
