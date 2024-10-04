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
	var sql_program_filters = "UPDATE programs SET show = %d WHERE program = '%s'"
	var sql_choice_filters = "UPDATE choices SET show = %d WHERE legacy_choice = '%s'"
	var db = AppDB.db
	
	var show_general = %GeneralCheckBox.button_pressed
	db.query(sql_program_filters % [1 if show_general else 0, "General"])
	var show_intensive = %IntensiveCheckBox.button_pressed
	db.query(sql_program_filters % [1 if show_intensive else 0, "Intensive"])

	var show_m1 = %Mon1.button_pressed
	db.query(sql_choice_filters % [1 if show_m1 else 0, "Mon01"])
	var show_m2 = %Mon2.button_pressed
	db.query(sql_choice_filters % [1 if show_m2 else 0, "Mon02"])
	var show_m3 = %Mon3.button_pressed
	db.query(sql_choice_filters % [1 if show_m3 else 0, "Mon03"])
	var show_w1 = %Wed1.button_pressed
	db.query(sql_choice_filters % [1 if show_w1 else 0, "Wed01"])
	var show_w2 = %Wed2.button_pressed
	db.query(sql_choice_filters % [1 if show_w2 else 0, "Wed02"])
	var show_w3 = %Wed3.button_pressed
	db.query(sql_choice_filters % [1 if show_w3 else 0, "Wed03"])
	var show_w4 = %Wed4.button_pressed
	db.query(sql_choice_filters % [1 if show_w4 else 0, "Wed04"])
	var show_w5 = %Wed5.button_pressed
	db.query(sql_choice_filters % [1 if show_w5 else 0, "Wed05"])
	var columns = Constants.DEMAND_COLUMN_NAMES

	printt("Filtered:", Utils.filtered_columns(columns))
	print("Choices: ", Utils.get_choices())
