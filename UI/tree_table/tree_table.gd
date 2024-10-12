extends Tree

var headers = []

var button_icon = preload("res://UI/Icons/expanded.svg")

var root : TreeItem

func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)

	button_clicked.connect(_on_assignment_btn_pressed)
	
	# Create the root item
	root = create_item()

	_load_data_and_render()
	

func _load_data_and_render():
	# Set Tree format and initialize headers
	_set_format_and_headers()

	Utils.free_all_treeitems(root)

	# Create a row for each student
	var students = [{"name": "Mary1", "program": "Intensive"}, {"name": "John", "program": "General"}]
	for student in students:
		_create_student_row(student, root)

	# Show Total Entries
	# get_parent().get_node("%TotalLbl").text = "( Total: %d )" % students.size()


func _set_format_and_headers():

	# Get weekday + start_time in a format suitable for the headers
	var headers = ["Name\n Second line", "Program", "Active"]
		
	# Set up the # of columns & titles
	set_columns(headers.size())
	for header in headers:
		match header:
			"Active":
				set_column_expand(headers.find(header), true)
				# set_column_min_width(headers.find(header), 50)
				# set_column_max_width(headers.find(header), 50)
				set_column_title(headers.find(header), header)
				set_column_title_alignment(headers.find(header), HORIZONTAL_ALIGNMENT_CENTER)
				set_column_custom_minimum_width(headers.find(header), 50)
			_:
				set_column_expand(headers.find(header), false)
				# set_column_min_width(headers.find(header), 100)
				# set_column_max_width(headers.find(header), 100)

	return


func _create_student_row(student, parent_node):
	# First sep: Fill in the student & choice data (left part)
	var _row = parent_node.create_child()
	var _columns = ["name", "program"]

	for column in _columns:
		var index = _columns.find(column)
		var txt = student[column]
		_row.set_text(index, str(txt) if txt else "-") 
		_row.set_text_alignment(index, HORIZONTAL_ALIGNMENT_LEFT)
		_row.set_editable(0, true)


func _on_assignment_btn_pressed(item: Object, _column: int, _id: , _mouse_button_index: int):
	pass


func _on_data_changed():
	_load_data_and_render()
