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

	match typeof(row[field]):
		TYPE_STRING:
			var lineEdit = field_scn.instantiate()
			lineEdit.text = str(row[field]) if row[field] else ""
			container.add_child(lineEdit)
		TYPE_INT:
			var spinbox = SpinBox.new()
			spinbox.value = row[field]
			container.add_child(spinbox)
		TYPE_BOOL:
			var checkBox : CheckBox = checkbox_scn.instantiate()
			checkBox.button_pressed = row[field]
			container.add_child(checkBox)
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
	var sql = "UPDATE %s SET {0}='{1}' WHERE {2} = '{3}'" % current_class.TABLE
	var sql_stmt

	var index = 0
	# EO FIX: This is updating SQL once for each field. Obviously, this is not the best way to do it.
	for field in container.get_children():
		print("Field:", field)
		if field is LineEdit:
			sql_stmt = sql.format([current_class.SHOW_COLUMNS[index], field.text, current_class.KEY, current_row[current_class.KEY]])
			AppDB.db_run(sql_stmt)
			index += 1
		elif field is SpinBox:
			sql_stmt = sql.format([current_class.SHOW_COLUMNS[index], field.value, current_class.KEY, current_row[current_class.KEY]])
			AppDB.db_run(sql_stmt)
			index += 1
		elif field is CheckBox:
			var active = 1 if field.button_pressed else 0
			sql_stmt = sql.format([current_class.SHOW_COLUMNS[index], active, current_class.KEY, current_row[current_class.KEY]])
			AppDB.db_run(sql_stmt)
			index += 1

	Signals.emit_data_changed()
	visible = false
			

func _on_delete_btn_pressed():
	var sql = "DELETE FROM {0} WHERE {1} = '{2}' "
	var sql_stm = sql.format([current_class.TABLE, current_class.KEY, current_row[current_class.KEY]])
	AppDB.db_run(sql_stm)
	visible = false
	Signals.emit_data_changed()
