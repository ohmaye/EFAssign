extends Tree

const sql_courses = "SELECT DISTINCT course_code FROM studentpreferences ORDER BY course_code"
const sql_levels = "SELECT DISTINCT level FROM studentpreferences WHERE course_code = '%s' ORDER BY level" 
const sql_students = "SELECT DISTINCT student_id, firstName, lastName, weekday FROM studentpreferences WHERE course_code = '%s' AND level = '%s' ORDER BY level"

func _ready():

	# Set up the columns & titles
	set_columns(3)
	set_column_title(0, "Course/Level/Student")
	set_column_custom_minimum_width(0,600)
	set_column_title(1, "Choice")
	set_column_title(2, "Total")
	
	# Create the root item
	var root = create_item()
	root.set_text(0, "(Shift click to hide/show all)")
	root.set_selectable(1,false)
	root.set_selectable(2,false)

	
	# Get Courses
	var courses = AssignDB.db_get(sql_courses)
	# Populate the tree with items
	for course in courses:
		var course_node = root.create_child()	
		course_node.set_text(0, course["course_code"])
		course_node.set_text(2, "1")
		course_node.set_selectable(1,false)
		course_node.set_selectable(2,false)
		# Get Levels
		var levels = AssignDB.db_get(sql_levels % course["course_code"])
		for level in levels:
			var level_entry = course_node.create_child()
			level_entry.set_text(0,level["level"])		
			level_entry.set_selectable(1,false)
			level_entry.set_selectable(2,false)
			var students = AssignDB.db_get(sql_students % [course["course_code"], level["level"]])
			for student in students:
				var student_node = level_entry.create_child()
				student_node.set_text(0, student["firstName"] + " " + student["lastName"])
				student_node.set_text(1, student["weekday"])
				student_node.set_text(2,"88")
				student_node.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
				student_node.set_text_alignment(2, HORIZONTAL_ALIGNMENT_CENTER)
				student_node.set_selectable(1,false)
				student_node.set_selectable(2,false)

func _on_column_title_clicked():
	print("Title clicked")

func _on_cell_selected():
	var students = []
	var student = get_next_selected(get_selected())
	while student:
		print("Cell selected", student)
		students += [student]
		student = get_next_selected(student)
	Signals.emit_signal("student_selected", students)
	
func _on_item_selected():
	print("Item selected", get_selected().get_text(0))
