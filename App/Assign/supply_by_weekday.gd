extends Supply

const sql_weekdays = """
WITH cls as (
	SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
	LEFT JOIN courses USING (course_id)
	LEFT JOIN rooms USING (room_id)
	LEFT JOIN timeslots USING (timeslot_id)
	LEFT JOIN teachers USING (teacher_id)
	)
SELECT DISTINCT cls.'when' FROM cls
"""

const sql_courses = """
	WITH cls as (
		SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
		LEFT JOIN courses USING (course_id)
		LEFT JOIN rooms USING (room_id)
		LEFT JOIN timeslots USING (timeslot_id)
		LEFT JOIN teachers USING (teacher_id)
		ORDER BY classes.title
		)
	SELECT * FROM cls
"""

func _ready():
	var db = AssignDB.db
	var result = db.query(sql_weekdays)

	var headers = ["Class"] 
	for timeslot in db.query_result:
		headers += [timeslot['when']]
	print(headers)

	# var query_info = QueryInfo.new("courses", COLUMN_NAMES, db.query_result, KEY )
	
	var label : Label 
	for column in headers:
		label = %Label.duplicate()
		label.text = column
		%Header.add_child(label)

	result = db.query(sql_courses)
	for row in db.query_result:
		var rowContainer : HBoxContainer = HBoxContainer.new()
		add_child(rowContainer)
		label = %Label.duplicate()
		label.text = row['course']
		rowContainer.add_child(label)