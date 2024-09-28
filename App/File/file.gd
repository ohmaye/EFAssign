extends ColorRect

@onready var container = %FileContent

var load_survey_scene = preload("res://App/file/LoadSurvey/load_survey.tscn")
var open_scene = preload("res://App/demand/Survey/survey.tscn")
var new_scene = preload("res://App/demand/Students/students.tscn")
var save_scene = preload("res://App/demand/ByStudent/by_student.tscn")
var save_as_scene = preload("res://App/demand/ByLevel/by_level.tscn")

func _ready() -> void:
	DisplayServer.window_set_title("Your Window Title")

## FILE TAB
##
## Handlers for Open, New, Save, Save As, Load Survey, and Quit

func _on_open_cycle_btn_pressed() -> void:
	Utils.change_scene(container, open_scene)

func _on_open_survey_btn_pressed() -> void:
	Utils.change_scene(container, load_survey_scene)

func _on_load_survey_btn_pressed() -> void:
	Utils.change_scene(container, load_survey_scene)
	
func _on_new_cycle_btn_pressed() -> void:
	Utils.change_scene(container, new_scene)

func _on_save_cycle_btn_pressed() -> void:
	Utils.change_scene(container, save_scene)

func _on_save_cycle_as_btn_pressed() -> void:
	Utils.change_scene(container, save_as_scene)


func _on_quit_btn_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
