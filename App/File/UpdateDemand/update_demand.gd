extends Control

var DB = AppDB.db

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_replace_demand_btn_pressed():
	var clearResult = _clear_demand()
	var loadResult = _load_demand()
	if clearResult:
		%StatusMsg.text = "Status: Students & Assignments & Demand Cleared\n"
	if loadResult:
		%StatusMsg.text += "Status: Demand Loaded"

func _on_add_demand_btn_pressed() -> void:
	print("Add to demand")

func _on_clear_demand_btn_pressed() -> void:
	var result = _clear_demand()
	if result:
		%StatusMsg.text = "Status: Students & Assignments & Demand Cleared"
	else:
		%StatusMsg.text = "Status: Could not clear all."


func _clear_demand() -> bool:
	var studentResult = DB.query("DELETE FROM students")
	var assignmentResult = DB.query("DELETE FROM assignments")
	var demandResult = DB.query("DELETE FROM demand") 

	return studentResult and assignmentResult and demandResult


func _load_students() -> bool:
	return true


func _load_demand() -> bool:
	var result = DB.query(INSERT_DEMAND_SQL)
	return result

const INSERT_DEMAND_SQL = """ 
	INSERT INTO demand (student_id, email, firstName,lastName, level, program, Mon01, Mon02, Mon03, Wed01, Wed02, Wed03, Wed04, Wed05, active)
	SELECT student_id, email, firstName, lastName, level, 
	CASE WHEN instr(program, "Intensive") THEN "Intensive" ELSE "General" END, 
	CASE WHEN instr(program, "Intensive") THEN IMon01 ELSE "" END, 
	CASE WHEN instr(program, "Intensive") THEN IMon02 ELSE "" END, 
	CASE WHEN instr(program, "Intensive") THEN IMon03 ELSE "" END, 
	CASE WHEN instr(program, "Intensive") THEN IWed01 ELSE GWed01 END, 
	CASE WHEN instr(program, "Intensive") THEN IWed02 ELSE GWed02 END, 
	CASE WHEN instr(program, "Intensive") THEN IWed03 ELSE GWed03 END, 
	CASE WHEN instr(program, "Intensive") THEN IWed04 ELSE GWed04 END, 
	CASE WHEN instr(program, "Intensive") THEN IWed05 ELSE GWed05 END,
	1 
	FROM survey;
	UPDATE demand SET Mon01 = substr(Mon01, instr(Mon01, '_') + 1);
	UPDATE demand SET Mon02 = substr(Mon02, instr(Mon02, '_') + 1);
	UPDATE demand SET Mon03 = substr(Mon03, instr(Mon03, '_') + 1);
	UPDATE demand SET Wed01 = substr(Wed01, instr(Wed01, '_') + 1);
	UPDATE demand SET Wed02 = substr(Wed02, instr(Wed02, '_') + 1);
	UPDATE demand SET Wed03 = substr(Wed03, instr(Wed03, '_') + 1);
	UPDATE demand SET Wed04 = substr(Wed04, instr(Wed04, '_') + 1);
	UPDATE demand SET Wed05 = substr(Wed05, instr(Wed05, '_') + 1);
"""