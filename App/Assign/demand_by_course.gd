extends Tree

const sql_courses = "SELECT DISTINCT course_code FROM studentpreferences ORDER BY course_code"
const sql_levels = "SELECT DISTINCT level FROM studentpreferences WHERE course_code = '%s' ORDER BY level" 
const sql_students = "SELECT DISTINCT student_id, firstName, lastName, weekday FROM studentpreferences WHERE course_code = '%s' AND level = '%s' ORDER BY level"

var root

func _ready():
	setup_tree_control()
	
	# Create the root item
	root = create_item()
	root.set_text(0, "(Shift click to hide/show all)")
	root.set_selectable(1,false)
	root.set_selectable(2,false)
	set_selected(root,0)

	# Get Courses
	var courses = AssignDB.db_get(sql_courses)
	# Populate the tree with items
	for course in courses:
		var course_node = _create_course_node(course, root)
		# Get Levels
		var levels = AssignDB.db_get(sql_levels % course["course_code"])
		for level in levels:
			var level_node = _create_level_node(level, course_node)
			var students = AssignDB.db_get(sql_students % [course["course_code"], level["level"]])
			for student in students:
				_create_student_node(student, level_node)


func setup_tree_control():
	# Set up the columns & titles
	set_columns(4)
	set_column_title(0, "Course/Level/Student")
	set_column_custom_minimum_width(0,600)
	set_column_title(1,"Select")
	set_column_title(2, "Choice")
	set_column_title(3, "Total")


func _create_course_node(_course, _parent):
	var course_node = _parent.create_child()	
	course_node.set_text(0, _course["course_code"])
	course_node.set_text(2, "1")
	course_node.set_selectable(1,false)
	course_node.set_selectable(2,false)
	course_node.set_selectable(3,false)
	course_node.set_metadata(0,"course")
	return course_node


func _create_level_node(_level, _parent):
	var level_node = _parent.create_child()
	level_node.set_text(0,_level["level"])		
	level_node.set_selectable(1,false)
	level_node.set_selectable(2,false)
	level_node.set_selectable(3,false)
	level_node.set_metadata(0,"level")
	return level_node


func _create_student_node(_student, _parent):
	var student_node = _parent.create_child()
	student_node.set_text(0, _student["firstName"] + " " + _student["lastName"])
	student_node.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
	student_node.set_text(2, _student["weekday"])
	student_node.set_text(3,"88")
	student_node.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_text_alignment(2, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_editable(1, true)
	student_node.set_selectable(1,false)
	student_node.set_selectable(2,false)
	student_node.set_selectable(3,false)
	student_node.set_metadata(0,"student")
	return student_node

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


func _on_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	print("Multi selection: ", item, " ", column, " ", selected, item.get_text(0))
	item.set_checked(1, selected)	
	# var selection : TreeItem
	# if !selected:
	# 	deselect_all()
	# 	item.select(0)

	# selection = get_next_selected(null)

	# var students = []

	# students = _get_selected_students(selection)

	# Signals.emit_signal("student_selected", students)
	# print("Selected students: ", students)


func _get_selected_students(selection) -> Array:
	var result = []

	if !selection:
		return result

	var metadata = selection.get_metadata(0)

	if metadata == "student":
		print("Meta is student")
		selection.select(0)
		return [selection]

	if metadata in ["course","level"]:
		print("Meta in course or level")
		var last_child
		for child in selection.get_children():
			result += _get_selected_students(child)
			last_child = child
		return result + _get_selected_students(get_next_selected(last_child))

	return []
