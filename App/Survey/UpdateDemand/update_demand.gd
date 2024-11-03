extends Control

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
		%StatusMsg.text += AppDB.db.error_message

func _on_clear_demand_btn_pressed() -> void:
	var result = _clear_demand()
	if result:
		%StatusMsg.text = "Status: Students & Assignments & Demand Cleared"
	else:
		%StatusMsg.text = "Status: Could not clear all."


func _clear_demand() -> bool:
	var assignmentResult = AppDB.db_run("DELETE FROM assignments")
	var student_choicesResult = AppDB.db_run("DELETE FROM student_choices") 
	var studentsResult = AppDB.db_run("DELETE FROM students") 
	
	return assignmentResult and student_choicesResult and studentsResult


func _load_demand() -> bool:
	# Insert students from the survey
	var studentsResult = AppDB.db_run(INSERT_STUDENTS_SQL)
	# Insert student_choices from the survey
	var student_choicesResult = AppDB.db_run(_get_insert_student_choices_sql())
	return studentsResult and student_choicesResult


# INSERT students based on the survey. Skip the first headers record.
const INSERT_STUDENTS_SQL = """ 
	INSERT INTO students (student_id, email, firstName, lastName, program, level, timestamp, active)
	SELECT student_id, email, firstName, lastName, program,
	level, timestamp, 1 FROM survey;
"""

# INSERT student choices based on the survey
func _get_insert_student_choices_sql() -> String:
	var choices = Utils.get_choices()
	
	var sql = "INSERT INTO student_choices (choice_id, student_id, choice, ranking, course_code) "

	for choice in choices:
		sql += "SELECT lower(hex(randomblob(16))) AS choice_id, student_id, '%s' AS choice, 1 AS ranking, substr(%s, instr(%s, '_') + 1) AS course_code FROM survey WHERE %s != '' " % [choice, choice, choice, choice]
		if choice != choices[-1]:
			sql += "UNION ALL "
		else:
			sql += ";"

	return sql


# Create student_choices directly from survey
const INSERT_STUDENT_CHOICES = """ 
INSERT INTO student_choices (choice_id, student_id, choice, ranking, course_code)
-- IM1 Preferences
SELECT lower(hex(randomblob(16))) AS choice_id, student_id,'IM1' AS choice, 1 AS ranking,
	substr(IM1, instr(IM1, '_') + 1) AS course_code
FROM survey WHERE IM1 != ''

UNION ALL 

-- IM2 Preferences
SELECT lower(hex(randomblob(16))) AS choice_id, student_id,'IM2' AS choice, 1 AS ranking,
	substr(IM2, instr(IM2, '_') + 1) AS course_code
FROM survey WHERE IM2 != ''
"""
