extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_new_cycle_btn_pressed():
	var clearResult = _clear_demand()
	if clearResult:
		%StatusMsg.text = "Status: Survey & Students & Assignments & Demand Cleared\n"
	GlobalVars.file_path = ""
	%StatusMsg.text = "Status: Using default empty DB"
	Utils.save_user_prefs()

func _clear_demand() -> bool:
	var assignmentResult = AppDB.db_run("DELETE FROM assignments")
	var demandResult = AppDB.db_run("DELETE FROM demand") 
	var surveyResult = AppDB.db_run("DELETE FROM survey")

	return assignmentResult and demandResult and surveyResult


## EO ToDo: Finish this module.