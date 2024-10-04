extends CanvasLayer

# Data 
var query_info : QueryInfo
var row 

# UI Elements
var label_scn = preload("res://UI/popup/popup_label.tscn")
var field_scn = preload("res://UI/popup/popup_field.tscn")
var separator = preload("res://UI/popup/h_separator.tscn")
var container
var gray_screen
var colorrect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container = %ItemsContainer
	colorrect = $ColorRect

func render(_row, _query_info : QueryInfo) -> void:
	Utils.free_all_children(container)
	query_info = _query_info
	row = _row

	for field in query_info.columns:
		var label = label_scn.instantiate()
		label.text = field.capitalize()
		container.add_child(label)

		var lineEdit = field_scn.instantiate()
		lineEdit.text = str(row[field]) if row[field] else ""
		container.add_child(lineEdit)

		var spacer = separator.instantiate()
		container.add_child(spacer)

		colorrect.gui_input.connect(_input_event)

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
		elif event.keycode == KEY_ENTER:
			# Handle the ENTER key press (e.g., save the data)
			_on_save_btn_pressed()
			hide()

func _on_cancel_btn_pressed() -> void:
	visible = false

func _on_save_btn_pressed() -> void:
	var db = AppDB.db
	const sql = "UPDATE {0} SET {1}='{2}' WHERE {3} = '{4}'"
	var sql_stmt

	var index = 0
	for field in container.get_children():
		if field is LineEdit:
			# print("Node:", row[query_info.key], query_info.columns[index], field.text)
			sql_stmt = sql.format([query_info.table, query_info.columns[index], field.text, query_info.key, row[query_info.key]])
			# print(sql_stmt)
			db.query(sql_stmt)
			index += 1

	Signals.emit_signal("data_changed")
	visible = false
			

func _on_delete_btn_pressed():
	var db = AppDB.db
	var sql = "DELETE FROM {0} WHERE {1} = '{2}' "
	var sql_stm = sql.format([query_info.table, query_info.key, row[query_info.key]])
	db.query(sql_stm)
	visible = false
	Signals.emit_signal("data_changed")
