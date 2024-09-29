extends ColorRect

@onready var container = %FileContent

var open_cycle_scene = preload("res://App/File/OpenCycle/open_cycle.tscn")
var open_survey_scene = preload("res://App/file/OpenSurvey/open_survey.tscn")
var update_demand_scene = preload("res://App/file/UpdateDemand/update_demand.tscn")
var new_cycle_scene = preload("res://App/demand/Students/students.tscn")
var save_cycle_scene = preload("res://App/demand/ByStudent/by_student.tscn")
var save_cycle_as_scene = preload("res://App/demand/ByLevel/by_level.tscn")

func _ready() -> void:
	DisplayServer.window_set_title("Your Window Title")

## FILE TAB
##
## Handlers for Open, New, Save, Save As, Load Survey, and Quit

func _on_open_cycle_btn_pressed() -> void:
	Utils.change_scene(container, open_cycle_scene)

func _on_open_survey_btn_pressed() -> void:
	Utils.change_scene(container, open_survey_scene)

func _on_update_demand_btn_pressed() -> void:
	Utils.change_scene(container, update_demand_scene)
	
func _on_new_cycle_btn_pressed() -> void:
	Utils.change_scene(container, new_cycle_scene)

func _on_save_cycle_btn_pressed() -> void:
	Utils.change_scene(container, save_cycle_scene)

func _on_save_cycle_as_btn_pressed() -> void:
	Utils.change_scene(container, save_cycle_as_scene)


func _on_quit_btn_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
