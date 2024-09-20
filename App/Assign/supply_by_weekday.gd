extends Supply

const sql_timeslots = """
WITH cls as (
	SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday as weekday, timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
	LEFT JOIN courses USING (course_id)
	LEFT JOIN rooms USING (room_id)
	LEFT JOIN timeslots USING (timeslot_id)
	LEFT JOIN teachers USING (teacher_id)
	ORDER BY classes.title
	)
SELECT DISTINCT cls.'when' FROM cls JOIN weekdays ON cls.weekday = weekdays.weekday ORDER BY weekdays.sort_key
"""

const sql_classes = """
WITH cls as (
	SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday as weekday, timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
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
	var label : Label 

	# Get weekdays appearing in supply
	var result = db.query(sql_timeslots)
	var timeslots = [] 
	for timeslot in db.query_result:
		timeslots += [timeslot['when']]
	
	# Render Headers
	var headers = ["Class"] + timeslots
	for column_name in headers:
		label = %Label.duplicate()
		label.text = column_name
		%Header.add_child(label)

	# Go through classes and for each populate the intersection if it exists
	result = db.query(sql_classes)
	for row in db.query_result:
		var row_node = %Row.duplicate()
		%Body.add_child(row_node)
		label = %Label.duplicate()
		label.text = row["class"] if row["class"] else ""
		row_node.add_child(label)
		for timeslot in timeslots:
			label = %Label.duplicate()
			label.text = "blah"
			row_node.add_child(label)