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
	var student_choicesResult = DB.query("DELETE FROM student_choices") 
	var studentsResult = DB.query("DELETE FROM students") 
	
	return assignmentResult and student_choicesResult and studentsResult


func _load_demand() -> bool:
	# Insert students from the survey
	var studentsResult = DB.query(INSERT_STUDENTS_SQL)
	# Insert student_choices from the survey
	var student_choicesResult = DB.query(INSERT_STUDENT_CHOICES)
	return studentsResult and student_choicesResult


# INSERT students based on the survey. Skip the first headers record.
const INSERT_STUDENTS_SQL = """ 
	INSERT INTO students (student_id, email, firstName, lastName, program, level, timestamp, active)
	SELECT student_id, email, firstName, lastName, 
	CASE WHEN instr(program, "Intensive") THEN "Intensive" ELSE "General" END, 
	level, timestamp, 1 FROM survey LIMIT -1 OFFSET 1;
"""


# Create student_choices directly from survey
const INSERT_STUDENT_CHOICES = """ 
WITH student_data AS (
  SELECT
    student_id,
    firstName,
    lastName,
    level,
    -- Determine the program type
    CASE WHEN instr(program, 'Intensive') THEN 'Intensive' ELSE 'General' END AS program,
    -- Adjust Mon and Wed columns based on the program type
    CASE WHEN instr(program, 'Intensive') THEN IMon01 ELSE '' END AS Mon01,
    CASE WHEN instr(program, 'Intensive') THEN IMon02 ELSE '' END AS Mon02,
    CASE WHEN instr(program, 'Intensive') THEN IMon03 ELSE '' END AS Mon03,
    CASE WHEN instr(program, 'Intensive') THEN IWed01 ELSE GWed01 END AS Wed01,
    CASE WHEN instr(program, 'Intensive') THEN IWed02 ELSE GWed02 END AS Wed02,
    CASE WHEN instr(program, 'Intensive') THEN IWed03 ELSE GWed03 END AS Wed03,
    CASE WHEN instr(program, 'Intensive') THEN IWed04 ELSE GWed04 END AS Wed04,
    CASE WHEN instr(program, 'Intensive') THEN IWed05 ELSE GWed05 END AS Wed05
  FROM survey
)

INSERT INTO student_choices (student_id, firstName, lastName, program, level, weekday, ranking, course_code)
-- Mon01 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Mon01' AS weekday,
  1 AS ranking,
  substr(Mon01, instr(Mon01, '_') + 1) AS course_code
FROM student_data
WHERE Mon01 != ''

UNION ALL

-- Mon02 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Mon02',
  2,
  substr(Mon02, instr(Mon02, '_') + 1)
FROM student_data
WHERE Mon02 != ''

UNION ALL

-- Mon03 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Mon03',
  3,
  substr(Mon03, instr(Mon03, '_') + 1)
FROM student_data
WHERE Mon03 != ''

UNION ALL

-- Wed01 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Wed01',
  1,
  substr(Wed01, instr(Wed01, '_') + 1)
FROM student_data
WHERE Wed01 != ''

UNION ALL

-- Wed02 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Wed02',
  2,
  substr(Wed02, instr(Wed02, '_') + 1)
FROM student_data
WHERE Wed02 != ''

UNION ALL

-- Wed03 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Wed03',
  3,
  substr(Wed03, instr(Wed03, '_') + 1)
FROM student_data
WHERE Wed03 != ''

UNION ALL

-- Wed04 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Wed04',
  4,
  substr(Wed04, instr(Wed04, '_') + 1)
FROM student_data
WHERE Wed04 != ''

UNION ALL

-- Wed05 Preferences
SELECT
  student_id,
  firstName,
  lastName,
  program,
  level,
  'Wed05',
  5,
  substr(Wed05, instr(Wed05, '_') + 1)
FROM student_data
WHERE Wed05 != '';
"""