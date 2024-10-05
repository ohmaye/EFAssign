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
	var sql_choice_filters = "UPDATE choices SET show = %d WHERE choice = '%s'"
	var db = AppDB.db
	
	var show_general = %GeneralCheckBox.button_pressed
	db.query(sql_program_filters % [1 if show_general else 0, "General"])
	var show_intensive = %IntensiveCheckBox.button_pressed
	db.query(sql_program_filters % [1 if show_intensive else 0, "Intensive"])

	var show_m1 = %IM1.button_pressed
	db.query(sql_choice_filters % [1 if show_m1 else 0, "IM1"])
	var show_m2 = %IM2.button_pressed
	db.query(sql_choice_filters % [1 if show_m2 else 0, "IM2"])
	var show_m3 = %IM3.button_pressed
	db.query(sql_choice_filters % [1 if show_m3 else 0, "IM3"])
	var show_w1 = %Ia1.button_pressed
	db.query(sql_choice_filters % [1 if show_w1 else 0, "Ia1"])
	var show_w2 = %Ia2.button_pressed
	db.query(sql_choice_filters % [1 if show_w2 else 0, "Ia2"])
	var show_w3 = %Ia3.button_pressed
	db.query(sql_choice_filters % [1 if show_w3 else 0, "Ia3"])
	var show_w4 = %Ia4.button_pressed
	db.query(sql_choice_filters % [1 if show_w4 else 0, "Ia4"])
	var show_w5 = %Ia5.button_pressed
	db.query(sql_choice_filters % [1 if show_w5 else 0, "Ia5"])
	var show_g1 = %Ga1.button_pressed
	db.query(sql_choice_filters % [1 if show_g1 else 0, "Ga1"])
	var show_g2 = %Ga2.button_pressed
	db.query(sql_choice_filters % [1 if show_g2 else 0, "Ga2"])
	var show_g3 = %Ga3.button_pressed
	db.query(sql_choice_filters % [1 if show_g3 else 0, "Ga3"])
	var show_g4= %Ga4.button_pressed
	db.query(sql_choice_filters % [1 if show_g4 else 0, "Ga4"])
	var show_g5 = %Ga5.button_pressed
	db.query(sql_choice_filters % [1 if show_g5 else 0, "Ga5"])
