extends Control

var home_scene = preload("res://App/Home/home.tscn")
var survey_scene = preload("res://App/Survey/survey.tscn")
var demand_scene = preload("res://App/Demand/demand.tscn")
var assign_scene = preload("res://App/Assign/assign.tscn")
var supply_scene = preload("res://App/Supply/supply.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_db_from_ui()

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


func _on_program_check_box_pressed() -> void:
	var sql_program_filters = "UPDATE programs SET show = %d WHERE program = '%s'"
	var show_general = %GeneralCheckBox.button_pressed
	AppDB.db_run(sql_program_filters % [1 if show_general else 0, "General"])
	var show_intensive = %IntensiveCheckBox.button_pressed
	AppDB.db_run(sql_program_filters % [1 if show_intensive else 0, "Intensive"])

	if not show_general and not show_intensive:
		_deactivate_all_choices()
	elif show_general and not show_intensive:
		_deactivate_all_choices()
		_activate_G_choices()
	elif not show_general and show_intensive:
		_deactivate_all_choices()
		_activate_I_choices()

	_update_ui_from_db()
	Signals.filters_changed.emit()
	Signals.data_changed.emit()


func _on_check_box_pressed() -> void:
	print("Pressed checkbox: ")
	_update_db_from_ui()
	Signals.filters_changed.emit()
	Signals.data_changed.emit()


func _update_db_from_ui():
	var sql_choice_filters = "UPDATE choices SET show = %d WHERE choice = '%s'"
	var db = AppDB.db
	var buttons = [%IM1, %IM2, %IM3, %Ia1, %Ia2, %Ia3, %Ia4, %Ia5, %Ga1, %Ga2, %Ga3, %Ga4, %Ga5]

	for button in buttons:
		var is_show = button.button_pressed
		db.query(sql_choice_filters % [1 if is_show else 0, button.name])


func _update_ui_from_db():
	var sql_choices_array = AppDB.db_get("SELECT choice, show FROM choices")
	print("Choices: ", sql_choices_array)
	var buttons = [%IM1, %IM2, %IM3, %Ia1, %Ia2, %Ia3, %Ia4, %Ia5, %Ga1, %Ga2, %Ga3, %Ga4, %Ga5]
	
	# Create a mapping from choice to show
	var sql_choices = {}
	for item in sql_choices_array:
		sql_choices[item["choice"]] = item["show"]
	
	for button in buttons:
		var show_value = sql_choices.get(button.name, 0)  # Default to 0 if not found
		button.button_pressed = show_value == 1


func _deactivate_all_choices():
	var sql_deactivate = "UPDATE choices SET show = 0"
	AppDB.db_run(sql_deactivate)


func _activate_I_choices():
	var sql_activate = "UPDATE choices SET show = 1 WHERE choice LIKE 'I%'"
	AppDB.db_run(sql_activate)


func _activate_G_choices():
	var sql_activate = "UPDATE choices SET show = 1 WHERE choice LIKE 'G%'"
	AppDB.db_run(sql_activate)
