extends Tree

# Uses classes_view, a denormalized view of classes, for all queries.
const sql_distinct_courses = "SELECT DISTINCT course FROM classes_view ORDER BY course"
const sql_classes_for_course = """SELECT cv.class_id, cv.title, cv.'when', cv.who 
									FROM classes_view AS cv WHERE course = '%s'"""
const sql_assignments_for_class = "SELECT student_id FROM assignments WHERE class_id = '%s'"

var root


func _ready():	
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)

	setup_tree_control()

	# Create the root item
	root = create_item()
	root.set_text(0, "(Shift click to hide/show all)")
	root.set_selectable(1,false)
	root.set_selectable(2,false)

	_load_data_and_render()


func setup_tree_control():
	# Set up the columns & titles
	set_columns(4)
	set_column_title(0, "Course/Class/Student")
	set_column_custom_minimum_width(0,300)
	set_column_title(1, "Time")
	set_column_title(2, "Teacher")
	set_column_title(3, "Assigned")


func _on_data_changed():
	_load_data_and_render() 


func _load_data_and_render():
	Utils.free_all_treeitems(root)
	# Go through classes and for each populate the intersection if it exists
	var courses = AppDB.db_get(sql_distinct_courses)
	for course in courses:
		var course_node = _create_course_node(course, root)
		course_node.set_selectable(0, false)
		# For each course, list the classes
		var classes = AppDB.db_get(sql_classes_for_course % course["course"])
		# print("Classes: ", classes)
		for _class in classes:
			var class_node = _create_class_node(_class, course_node)
			var assignments = AppDB.db_get(sql_assignments_for_class % _class["class_id"])	
			for student in assignments:
				_create_student_node(student, class_node)


func _create_course_node(_course, _parent):
	var course_node = _parent.create_child()
	course_node.set_text(0, _course["course"])
	return course_node


func _create_class_node(_class, _parent):
	var class_title = _class["title"] if _class["title"] else "?"
	var class_node = _parent.create_child()
	# Save class for assignment
	class_node.set_metadata(1, _class)

	class_node.set_text(0,class_title)
	var class_time = _class["when"] if _class["when"] else "/"
	class_node.set_text(1, class_time)
	var class_teacher = _class["who"] if _class["who"] else "?"
	class_node.set_text(2, class_teacher)
	class_node.set_text(3, "0")
	class_node.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
	class_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	return class_node

func _create_student_node(_student, _parent):
	var student_node = _parent.create_child()
	# print("Student ID: ", _student["student_id"]) 
	var student_details = AppDB.db_get("SELECT firstName, lastName FROM students WHERE student_id = '%s'" % _student["student_id"])
	var student_name = student_details[0]["firstName"] + " " + student_details[0]["lastName"]
	student_node.set_text(0, student_name)
	student_node.set_custom_color(0, Color("#0000ff"))
	student_node.set_text(1, "")
	student_node.set_text(2, "")
	student_node.set_text(3, "")
	student_node.set_selectable(1, true)
	student_node.set_selectable(2, false)
	student_node.set_selectable(3, false)
	return student_node

func _on_cell_selected():
	print("Cell selected")
	
func _on_item_selected():
	var _class = get_selected().get_metadata(1)
	print("Item selected", _class)
	if _class:
		Signals.emit_signal("class_selected", _class )
