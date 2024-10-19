extends Controller

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName COLLATE NOCASE, lastName COLLATE NOCASE"

var button_icon = preload("res://UI/Icons/drop_down.svg")

@onready var tree : Tree = %AssignmentsTree
@onready var filters_container = %FiltersGridContainer
@onready var field_container = %FieldContainer
@onready var popup_menu : PopupMenu = %ClassesPopupMenu

var root : TreeItem
var active_timeslots : Array[TimeSlot] = []
var demand_columns = []
var assignment_columns = []
var headers = []
var filters = {}

func _ready():
	# Create the root item
	root = tree.create_item()

	_load_data_and_render()
	
	tree.button_clicked.connect(_on_assignment_btn_pressed)
	tree.column_title_clicked.connect(func (_column, _index): _sort_tree(_column)	)

	resized.connect(_resize_filters)


func _on_data_changed():
	_load_data_and_render()


func _load_data_and_render():
	# Set Tree format and initialize headers
	_setup_tree_format_and_headers()

	# Clean up Tree then create a row for each student
	Utils.free_all_treeitems(root)
	var student_demands = AppDB.db_get_objects(DemandView, sql)
	for student in student_demands:
		_create_student_demand_row(student, root)

	# Set up column filters after rendering content for proper alignment
	_setup_column_filters()
	# Show Total Entries
	# get_parent().get_parent().get_parent().get_node("%TotalLbl").text = "( Total: %d )" % demands.size()


func _setup_tree_format_and_headers():
	# For this view, don't show email. Note that they are filtered in the SQL query
	demand_columns = AppDB.filtered_columns(DemandView.SHOW_COLUMNS).filter(func(column):
		return column != "email"
	)

	# Get weekday + start_time in a format suitable for the headers
	active_timeslots = AppDB.get_active_timeslots()
	assignment_columns = []
	for timeslot in active_timeslots:
		assignment_columns.append(timeslot.weekday + " " + timeslot.start_time)
		
	# Combine headers for student choices with active assignment_columns
	headers = demand_columns + assignment_columns

	# Set up the # of columns & titles
	tree.set_columns(headers.size())
	for header in headers:
		tree.set_column_title(headers.find(header), header)

	return

		
func _create_student_demand_row(demand : DemandView, parent_node):
	# First sep: Fill in the student & choice data (left part)
	var _row = parent_node.create_child()

	for column in demand_columns:
		var index = demand_columns.find(column)
		var txt = demand.get(column)
		_row.set_text(index, str(txt) if txt else "-") 
		tree.set_column_custom_minimum_width(index, 200)
		_row.set_text_alignment(index, HORIZONTAL_ALIGNMENT_CENTER)
		if _is_course_assigned_for_student(demand['student_id'], demand.get(column)):
			_row.set_custom_bg_color(index, "#A3E9FF")

	# Second sep: Fill in the assignment data (right part)
	for timeslot in active_timeslots:
		# Prepare demand metadata to pass to the button
		var assignment_metadata = {"demand": demand}

		var index = active_timeslots.find(timeslot)
		var timeslot_index = demand_columns.size() + index 
		
		# If student has an assignment in this timeslot, show the class title and store it as metadata
		var assignment_info = _get_assignment_info_in_timeslot(demand['student_id'], timeslot)
		var assignment = assignment_info[0] if assignment_info else null
		if assignment:
			var title = assignment.get('title') if assignment.get('title') else "???"
			_row.set_text(timeslot_index, title)
			_row.set_text_alignment(timeslot_index, HORIZONTAL_ALIGNMENT_CENTER)
			if assignment_info.size() > 1:
				_row.set_custom_bg_color(timeslot_index, "#FF0000")
			else:
				_row.set_custom_bg_color(timeslot_index, "#91E2A4")
			tree.set_column_custom_minimum_width(timeslot_index, 280)
			assignment_metadata["assignment_info"] = assignment
			assignment_metadata["timeslot"] =  timeslot
		else:
			_row.set_custom_bg_color(timeslot_index, "#A3FFD8")
			assignment_metadata["assignment_info"] = null
			assignment_metadata["timeslot"] =  timeslot

		_row.set_metadata(timeslot_index, assignment_metadata)
		_row.add_button(timeslot_index, button_icon)

## Filtering and Sorting
func _setup_column_filters() -> void:
	# Clear the filters container
	Utils.free_all_children(filters_container)
	filters_container.columns = headers.size()

	for i in headers.size():
		var filter = field_container.duplicate()
		var filter_text = filters[headers[i]] if filters.has(headers[i]) else ""
		filter.get_node("Field").text = filter_text
		filter.visible = true
		var column_width = tree.get_column_width(i) - 3
		filter.custom_minimum_size = Vector2(column_width, 50)
		filters_container.add_child(filter)
		filter.get_node("Field").text_submitted.connect(_on_filter_text_submitted)

	_apply_filters()
	call_deferred("_resize_filters")


func _on_filter_text_submitted(text):
	print("Filter Text Submitted: ", text)
	for i in headers.size():
		var filter = filters_container.get_child(i)
		var filter_text = filter.get_node("Field").text
		filters[headers[i]] = filter_text
	print("Filters: ", filters)
	_apply_filters()


func _apply_filters():
	for row in range(root.get_child_count()):
		var item = root.get_child(row)
		var show_row = true
		for col in range(headers.size()):
			var cell_text = item.get_text(col)
			if filters.get(headers[col]) != null and not cell_text.to_lower().begins_with(filters.get(headers[col]).to_lower()):
				print("Cell Text: ", cell_text)		
				show_row = false
				break
		item.visible = show_row


func _resize_filters():
	for i in headers.size():
		var filter = filters_container.get_child(i)
		var column_width = tree.get_column_width(i) - 3
		filter.custom_minimum_size = Vector2(column_width, 50)


var sort_order = {}
func _sort_tree(column: int, ascending: bool = true):
	var items = []
	for i in range(root.get_child_count()):
		items.append(root.get_child(i))

	if column in sort_order:
		sort_order[column] = not sort_order[column]
	else:
		sort_order[column] = ascending

	items.sort_custom(func (a,b): return _compare_items(a,b,column,sort_order[column]))

	# Clear the root and add items back in sorted order
	for item in items:
		root.remove_child(item)
	for item in items:
		root.add_child(item)

func _compare_items(a, b, column, ascending):
	var text_a = a.get_text(column)
	var text_b = b.get_text(column)
	if ascending:
		return text_a.naturalnocasecmp_to(text_b) < 0
	else:
		return text_a.naturalnocasecmp_to(text_b) > 0


## Handling events

# When the button is clicked, show the popup menu to assign a class in a timeslot
func _on_assignment_btn_pressed(item: Object, _column: int, _id: , _mouse_button_index: int):
	popup_menu.visible = true
	popup_menu.position = get_global_mouse_position() - Vector2(400, 0) # EO FIXME: Magic number
	# Pass the metadata to the popup menu, which is the student's assignment
	printt("Metadata: ", item.get_metadata(_column))
	var _metadata = item.get_metadata(_column)
	popup_menu.load_and_render(_metadata["demand"], _metadata["assignment_info"], _metadata["timeslot"])


# EO FIX: Should these be turned into a dictionary loaded only when data changes?
const sql_assignment_in_timeslot = """
		SELECT a.assignment_id, a.student_id, a.class_id, cv.title, cv.course FROM assignments a
		JOIN classes_view AS cv USING (class_id)
		WHERE a.student_id = '%s' AND cv.timeslot_id = '%s';
"""
func _get_assignment_info_in_timeslot(student_id, timeslot : TimeSlot):
	var sql_stmt = sql_assignment_in_timeslot % [student_id, timeslot.timeslot_id]
	var result = AppDB.db_get(sql_stmt)
	# if result.size() != 0:
	# 	printt("Assignment found for student: ", result[0])

	return null if result.size() == 0 else result


const sql_course_assigned_to_student = """
		SELECT a.assignment_id, a.student_id, a.class_id, cv.title, cv.course FROM assignments a
		JOIN classes_view AS cv USING (class_id)
		WHERE a.student_id = '%s' AND cv.course = '%s';
"""
func _is_course_assigned_for_student(student_id, course_code):
	var sql_stmt = sql_course_assigned_to_student % [student_id, course_code]
	var result = AppDB.db_get(sql_stmt)
	return result.size() != 0
