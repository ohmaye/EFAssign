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
	var loadResult = _load_demand()
	if loadResult:
		%StatusMsg.text += "Status: Demand Added"
	else:
		%StatusMsg.text += "Status: There was a problem adding from the survey\n"
		%StatusMsg.text += DB.error_message

func _on_clear_demand_btn_pressed() -> void:
	var result = _clear_demand()
	if result:
		%StatusMsg.text = "Status: Students & Assignments & Demand Cleared"
	else:
		%StatusMsg.text = "Status: Could not clear all."


func _clear_demand() -> bool:
	var assignmentResult = DB.query("DELETE FROM assignments")
	var demandResult = DB.query("DELETE FROM demand") 
	
	# EO Cannot do this (below) when the update is partial
	var studentPreferencesResult = DB.query("DELETE FROM studentpreferences") 

	return assignmentResult and demandResult and studentPreferencesResult


func _load_demand() -> bool:
	var demandResult = DB.query(INSERT_DEMAND_SQL)
	# StudentPrerences for now created as a table. Could be a VIEW instead.
	var studentPreferencesResult = DB.query(INSERT_STUDENT_PREFERENCES)
	return demandResult and studentPreferencesResult


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


const INSERT_STUDENT_PREFERENCES = """ 
	INSERT INTO studentpreferences (student_id, firstName, lastName, program, level, weekday, ranking, course_code)
	SELECT student_id, firstName, lastName, program, level, 'Mon01', 1, Mon01 FROM demand WHERE Mon01 IS NOT '' 
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Mon02', 2, Mon02 FROM demand WHERE Mon02 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Mon03', 3, Mon03 FROM demand WHERE Mon03 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Wed01', 1, Wed01 FROM demand WHERE Wed01 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Wed02', 2, Wed02 FROM demand WHERE Wed02 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Wed03', 3, Wed03 FROM demand WHERE Wed03 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Wed04', 4, Wed04 FROM demand WHERE Wed04 IS NOT ''
	UNION ALL
	SELECT student_id, firstName, lastName, program, level, 'Wed05', 5, Wed05 FROM demand WHERE Wed05 IS NOT '';
"""