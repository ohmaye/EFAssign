extends Tree

func _ready():

	# Set up the columns & titles
	set_columns(3)
	set_column_title(0, "Course/Level/Student")
	set_column_title(1, "Choice")
	set_column_title(2, "Total")
	set_column_custom_minimum_width(0,600)
	
	# Create the root item
	var root = create_item()
	
	# Get Courses
	var db = AssignDB.db
	const sql_courses = "SELECT DISTINCT course_code FROM studentpreferences ORDER BY course_code"
	db.query(sql_courses)
	var courses = db.query_result
	# Populate the tree with items
	for course in courses:
		var course_entry = root.create_child()
		root.set_text(0, "(Shift click to hide/show all)")
		course_entry.set_text(0, course["course_code"])
		course_entry.set_text(2, "1")
		# Get Levels
		var sql_levels = "SELECT DISTINCT level FROM studentpreferences WHERE course_code = '%s' ORDER BY level" % course["course_code"]
		db.query(sql_levels)
		var levels = db.query_result
		for level in levels:
			var level_entry = course_entry.create_child()
			level_entry.set_text(0,level["level"])		
			var sql_students = "SELECT DISTINCT student_id, firstName, lastName, weekday FROM studentpreferences WHERE course_code = '%s' AND level = '%s' ORDER BY level" % [course["course_code"], level["level"]]
			db.query(sql_students)
			var students = db.query_result
			for student in students:
				var str_entry = level_entry.create_child()
				str_entry.set_text(0, student["firstName"] + " " + student["lastName"])
				str_entry.set_text(1, student["weekday"])
				str_entry.set_text(2,"88")
				str_entry.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
				str_entry.set_text_alignment(2, HORIZONTAL_ALIGNMENT_CENTER)

func _on_column_title_clicked():
	print("Title clicked")

func _on_cell_selected():
	print("Cell selected")
	
func _on_item_selected():
	print("Item selected", get_selected().get_text(0))
