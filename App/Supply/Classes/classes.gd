extends Controller

const COLUMN_NAMES  = Constants.CLASSES_COLUMN_NAMES
const KEY = Constants.CLASSES_KEY

const sql = """
	SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
	LEFT JOIN courses USING (course_id)
	LEFT JOIN rooms USING (room_id)
	LEFT JOIN timeslots USING (timeslot_id)
	LEFT JOIN teachers USING (teacher_id)
"""

func render():
	var db = AssignDB.db
	var result = db.query(sql)

	# If there are no results, return
	if not result:
		return

	var query_info = QueryInfo.new("courses", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)
