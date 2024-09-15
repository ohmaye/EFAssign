extends Supply

const COLUMN_NAMES  = Constants.BY_LEVEL_COLUMN_NAMES
const KEY = Constants.BY_LEVEL_KEY

func _ready() -> void:
	render()

func render():
	# Enable Intensive/General
	# GlobalVars.intensive_checkbox.disabled = true
	# GlobalVars.general_checkbox.disabled = true
	var node

	var db = AssignDB.db    
	var result = db.query(sql_courses)

	# If there are no results, return
	if not result:
		return

	var courses = db.query_result
		
	var grid = GridContainer.new()
	grid.columns = courses.size() + 1
	add_child(grid)

	# Render headers (courses)
	node = Label.new()
	node.text = "Teacher"
	grid.add_child(node)
	for course in courses:
		node = Label.new()
		node.text = course.code
		grid.add_child(node)

	result = db.query(sql_teachers)

	if not result:
		return

	var teachers = db.query_result

	for teacher in teachers:
		node = Label.new()
		node.text = teacher.name
		grid.add_child(node)
		for course in courses:
			result = db.query(sql_rating.format([course.course_id, teacher.teacher_id]))
			node = Label.new()
			node.text = str(db.query_result[0].rating) if db.query_result.size() > 0 else ""
			# print("Rating: ", db.query_result)
			grid.add_child(node)

	
	# var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

	# $Table.render(query_info)


const sql_courses = """
	SELECT DISTINCT course_id, code, title FROM courses WHERE active = 'true' ORDER BY code
"""
const sql_teachers = """
	SELECT DISTINCT teacher_id, name FROM teachers WHERE active = 'true' ORDER BY name
"""

const sql_rating = """
	SELECT rating FROM teacherpreferences WHERE course_id = '{0}' AND teacher_id = '{1}'
"""
