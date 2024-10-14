extends Controller

var grid
var node

const progress_bar = preload("res://UI/progress_bar/progress_bar.tscn")


func _ready():
	grid = %ContentGrid

	# Load Courses (header)
	var courses = AppDB.db_get(sql_courses)

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
	var teachers = AppDB.db_get(sql_teachers)

	for teacher in teachers:
		node = Label.new()
		node.text = teacher.name
		grid.add_child(node)
		for course in courses:
			var ratings = AppDB.db_get(sql_rating.format([course.course_id, teacher.teacher_id]))
			node = progress_bar.instantiate()
			node.value = ratings[0].rating if ratings.size() > 0 else 0
			grid.add_child(node)


const sql_courses = """
	SELECT DISTINCT course_id, code, title FROM courses WHERE active = 1 ORDER BY code
"""
const sql_teachers = """
	SELECT DISTINCT teacher_id, name FROM teachers WHERE active = 1 ORDER BY name COLLATE NOCASE
"""

const sql_rating = """
	SELECT rating FROM teacherpreferences WHERE course_id = '{0}' AND teacher_id = '{1}'
"""
