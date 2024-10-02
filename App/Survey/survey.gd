extends ColorRect

@onready var container = %FileContent

var open_survey_scene = preload("res://App/Survey/OpenSurvey/open_survey.tscn")
var survey_scene = preload("res://App/Survey/Survey/survey.tscn")
var update_demand_scene = preload("res://App/Survey/UpdateDemand/update_demand.tscn")

## FILE TAB
##
## Handlers for Open, New, Save, Save As, Load Survey, and Quit

func _on_open_survey_btn_pressed() -> void:
	Utils.change_scene(container, open_survey_scene)


func _on_survey_btn_pressed() -> void:
	Utils.change_scene(container, survey_scene)


func _on_update_demand_btn_pressed() -> void:
	Utils.change_scene(container, update_demand_scene)
	

