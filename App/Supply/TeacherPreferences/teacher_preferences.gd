extends Controller

var grid
var node
var db = AppDB.db

const progress_bar = preload("res://UI/progress_bar/progress_bar.tscn")


func _ready():
	grid = %ContentGrid

	# Load Courses (header)
	var result = db.query(sql_courses)
	# If there are no results, return
	if not result:
		return
	var courses = db.query_result

	# Render headers (courses)
	grid.columns = courses.size() + 1		
	node = Label.new()
	node.text = "Teacher"
	grid.add_child(node)
	for course in courses:
		node = Label.new()
		node.text = course.code
		grid.add_child(node)

	# Load Teachers
	result = db.query(sql_teachers)
	# If there are no results, return
	if not result:
		return
	var teachers = db.query_result

	for teacher in teachers:
		node = Label.new()
		node.text = teacher.name
		grid.add_child(node)
		for course in courses:
			result = db.query(sql_rating.format([course.course_id, teacher.teacher_id]))
			node = progress_bar.instantiate()
			node.value = db.query_result[0].rating if db.query_result.size() > 0 else 0
			grid.add_child(node)


const sql_courses = """
	SELECT DISTINCT course_id, code, title FROM courses WHERE active = 'true' ORDER BY code
"""
const sql_teachers = """
	SELECT DISTINCT teacher_id, name FROM teachers WHERE active = 'true' ORDER BY name
"""

const sql_rating = """
	SELECT rating FROM teacherpreferences WHERE course_id = '{0}' AND teacher_id = '{1}'
"""
