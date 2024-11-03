extends CanvasLayer

# Data 
var current_class
var current_row 

# UI Elements
var label_scn = preload("popup_label.tscn")
var field_scn = preload("popup_field.tscn")
var checkbox_scn = preload("res://UI/check_box.tscn")
var separator = preload("h_separator.tscn")
var container : Control 
var backdrop : Control

# UI Nodes with edited data
var title_node : LineEdit
var course_node : OptionButton
var room_node : OptionButton
var timeslot_node : OptionButton
var teacher_node : OptionButton
var for_program_node : OptionButton

# Dropdowns (Course, Room, Timeslot, Teacher)
const teacher_options = preload("res://App/Supply/Classes/popup/teacher_options.tscn")
const course_options = preload("res://App/Supply/Classes/popup/course_options.tscn")
const room_options = preload("res://App/Supply/Classes/popup/room_options.tscn")
const timeslot_options = preload("res://App/Supply/Classes/popup/timeslot_options.tscn")
const program_options = preload("res://App/Supply/Classes/popup/program_options.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container = %ItemsContainer
	backdrop = $BackdropColorRect

func render(_row, _class) -> void:
	Utils.free_all_children(container)
	current_row = _row
	current_class = _class

	backdrop.gui_input.connect(_input_event)

	for field in current_class.SHOW_COLUMNS:
		_create_field(field, current_row)

		var spacer = separator.instantiate()
		container.add_child(spacer)


func _create_field(field, row):
	# Add a label for the field
	var label = label_scn.instantiate()
	label.text = field.capitalize()
	container.add_child(label)

	match field:
		"title":
			title_node = field_scn.instantiate()
			title_node.text = str(row[field]) if row[field] else ""
			container.add_child(title_node)
		"course":
			course_node = course_options.instantiate()
			container.add_child(course_node)
			course_node._render(row)
		"for_program":
			for_program_node = program_options.instantiate()
			container.add_child(for_program_node)
			for_program_node._render(row)
		"when":
			timeslot_node = timeslot_options.instantiate()
			container.add_child(timeslot_node)
			timeslot_node._render(row)
		"where":
			room_node = room_options.instantiate()
			container.add_child(room_node)
			room_node._render(row)
		"who":
			teacher_node = teacher_options.instantiate()
			container.add_child(teacher_node)
			teacher_node._render(row)
		_:
			print("Unknown type")


func _input_event(event):
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Hide the popup
		hide()

func _input(event):
	# Check if the event is a key press event
	if event is InputEventKey:
		# Check if the key pressed is the ESC key
		if event.keycode == KEY_ESCAPE:
			# Handle the ESC key press (e.g., hide the popup)
			hide()
		# Check if the key pressed is the ENTER key
		# EO Fix: Disabling ENTER below because it interferes with filters
		# elif event.keycode == KEY_ENTER:
		# 	# Handle the ENTER key press (e.g., save the data)
		# 	print("ENTER key pressed caught in popup.gd")
		# 	_on_save_btn_pressed()
		# 	hide()

func _on_cancel_btn_pressed() -> void:
	visible = false

func _on_save_btn_pressed() -> void:
	var sql = """UPDATE classes SET 
		title='%s',
		teacher_id='%s',
		course_id='%s',
		room_id='%s',
		timeslot_id='%s',
		for_program='%s'
		WHERE class_id = '%s'
	""" 

	var class_id = current_row["class_id"]
	var title = title_node.text
	var teacher_id = teacher_node.selected_teacher_id
	var course_id = course_node.selected_course_id
	var room_id = room_node.selected_room_id
	var timeslot_id = timeslot_node.selected_timeslot_id
	var for_program = for_program_node.text

	print("Class_id:", class_id, "Title:", title, "Teacher ID:", teacher_id, "Course ID:", course_id, "Room ID:", room_id, "Timeslot ID:", timeslot_id, "For Program:", for_program)

	var sql_stmt = sql % [title, teacher_id, course_id, room_id, timeslot_id, for_program, class_id]
	AppDB.db_run(sql_stmt)

	Signals.emit_data_changed()
	visible = false
			

func _on_delete_btn_pressed():
	var sql = "DELETE FROM classes WHERE class_id = '%s' "
	var sql_stm = sql % current_row[current_class.KEY]
	AppDB.db_run(sql_stm)
	visible = false
	Signals.emit_data_changed()
