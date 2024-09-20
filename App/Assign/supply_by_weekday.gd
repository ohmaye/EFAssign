extends Tree

func _ready():	
	
	# Set up the columns & titles
	set_columns(3)
	set_column_title(0, "Course/Class")
	set_column_title(1, "Time")
	set_column_title(2, "Teacher")
	set_column_title(3, "Assigned")

	# Create the root item
	var root = create_item()
	
	var db = AssignDB.db

	# Go through classes and for each populate the intersection if it exists
	db.query(sql_distinct_courses)
	for row in db.query_result:
		var course = row["course"]
		var course_node = root.create_child()
		course_node.set_text(0, course)
		# For each course, list the classes
		db.query(sql_classes_for_course % course)
		for class_info in db.query_result:
			var class_node = course_node.create_child()
			var class_title = class_info["class"] if class_info["class"] else "?"
			class_node.set_text(0,class_title)
			var time_title = class_info["when"] if class_info["when"] else "/"
			class_node.set_text(1, time_title)
			var teacher_name = class_info["who"] if class_info["who"] else "?"
			class_node.set_text(2, teacher_name)
			class_node.set_text(3, "0")


# Uses classes_view, a denormalized view of classes, for all queries.
const sql_distinct_courses = """
	SELECT DISTINCT course FROM classes_view ORDER BY course
"""

const sql_classes_for_course = """
	SELECT DISTINCT cv.class, cv.'when', cv.who FROM classes_view AS cv WHERE course = '%s'
	"""
