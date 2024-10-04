extends Tree

const sql_courses = "SELECT DISTINCT course_code FROM filtered_student_choices_view ORDER BY course_code"
const sql_levels = "SELECT DISTINCT level FROM filtered_student_choices_view WHERE course_code = '%s' ORDER BY level" 
const sql_students = """SELECT DISTINCT student_id, firstName, lastName, weekday 
					FROM filtered_student_choices_view 
					WHERE course_code = '%s' AND level = '%s' ORDER BY level"""

var root
var selections = {}

func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)

	setup_tree_control()
	
	# Create the root item
	root = create_item()
	root.set_metadata(0,"root")

	root.set_text(0, "(Shift click to hide/show all)")
	root.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	root.set_selectable(1,false)
	root.set_selectable(2,false)
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render() 


func _load_data_and_render():
	Utils.free_all_treeitems(root)
	# Get Courses
	var courses = AppDB.db_get(sql_courses)
	# Populate the tree with items
	for course in courses:
		var course_node = _create_course_node(course, root)
		# Get Levels
		var levels = AppDB.db_get(sql_levels % course["course_code"])
		for level in levels:
			var level_node = _create_level_node(level, course_node)
			var students = AppDB.db_get(sql_students % [course["course_code"], level["level"]])
			for student in students:
				_create_student_node(student, level_node)

	# Update Counts after the tree is built
	_update_counts(root)


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
	course_node.set_metadata(0,"course")

	course_node.set_text(0, _course["course_code"])
	course_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	course_node.set_selectable(1,false)
	course_node.set_selectable(2,false)
	course_node.set_selectable(3,false)
	return course_node


func _create_level_node(_level, _parent):
	var level_node = _parent.create_child()
	level_node.set_text(0,_level["level"])	

	level_node.set_metadata(0,"level")
	level_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	level_node.set_selectable(1,false)
	level_node.set_selectable(2,false)
	level_node.set_selectable(3,false)
	return level_node


func _create_student_node(_student, _parent):
	var student_node = _parent.create_child()
	student_node.set_metadata(0,"student")

	student_node.set_text(0, _student["firstName"] + " " + _student["lastName"])
	student_node.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
	student_node.set_text(2, _student["weekday"])
	student_node.set_text(3,"")
	student_node.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_text_alignment(2, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_text_alignment(3, HORIZONTAL_ALIGNMENT_CENTER)
	student_node.set_editable(1, true)
	student_node.set_selectable(1,false)
	student_node.set_selectable(2,false)
	student_node.set_selectable(3,false)
	return student_node

func _on_column_title_clicked():
	print("Title clicked")


func _on_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	print("Multi selection: ", item, " ", column, " ", selected)

	_update_selections(item, column, selected)
	
	Signals.emit_signal("student_selected", selections) 
		
func _update_selections(item: TreeItem, column: int, selected: bool) -> void:
	var metadata = item.get_metadata(0)

	if metadata in ["root", "course","level"]:
		# print("Meta in course or level")
		for child in item.get_children():
			_update_selections(child, column, selected)

	if metadata == "student":
		print("Student : ", selected, " - ", item.get_text(0))
		item.set_checked(1, selected)
		if selected:
			selections[item.get_text(0)] = true
		else:
			selections.erase(item.get_text(0))

# func _update_counts() -> void:
# 	root.set_text(3, str(_count_students(root)))

func _update_counts(item) -> int:
	var count = 0
	var metadata = item.get_metadata(0)

	if metadata in ["root", "course","level"]:
		for child in item.get_children():
			count += _update_counts(child)

	if metadata == "student":
		count = 1
	else: 
		item.set_text(3, str(count))
	
	return count
