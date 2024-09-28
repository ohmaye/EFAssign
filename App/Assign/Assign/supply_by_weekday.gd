extends Tree

# Uses classes_view, a denormalized view of classes, for all queries.
const sql_distinct_courses = "SELECT DISTINCT course FROM classes_view ORDER BY course"
const sql_classes_for_course = """SELECT DISTINCT cv.class, cv.'when', cv.who 
									FROM classes_view AS cv WHERE course = '%s'"""


func _ready():	
	setup_tree_control()

	# Create the root item
	var root = create_item()
	root.set_text(0, "(Shift click to hide/show all)")

	# Go through classes and for each populate the intersection if it exists
	var courses = AppDB.db_get(sql_distinct_courses)
	for course in courses:
		var course_node = _create_course_node(course, root)
		# For each course, list the classes
		var classes = AppDB.db_get(sql_classes_for_course % course["course"])
		for _class in classes:
			_create_class_node(_class, course_node)


func setup_tree_control():
	# Set up the columns & titles
	set_columns(4)
	set_column_title(0, "Course/Class")
	set_column_custom_minimum_width(0,300)
	set_column_title(1, "Time")
	set_column_title(2, "Teacher")
	set_column_title(3, "Assigned")


func _create_course_node(_course, _parent):
	var course_node = _parent.create_child()
	course_node.set_text(0, _course["course"])
	return course_node


func _create_class_node(_class, _parent):
	var class_title = _class["class"] if _class["class"] else "?"
	var class_node = _parent.create_child()
	class_node.set_text(0,class_title)
	var class_time = _class["when"] if _class["when"] else "/"
	class_node.set_text(1, class_title)
	var class_teacher = _class["who"] if _class["who"] else "?"
	class_node.set_text(2, class_teacher)
	class_node.set_text(3, "0")
	class_node.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
	class_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	return class_node


func _on_cell_selected():
	print("Cell selected")
	
func _on_item_selected():
	var class_title = get_selected().get_text(0)
	print("Item selected", class_title)
	Signals.emit_signal("class_selected", class_title )
