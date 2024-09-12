extends CanvasLayer

signal data_changed

# Data 
var db_table
var item_id
var item_row
var item_columns

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

func render(id, row, columns, table) -> void:
	remove_all_children(container)
	db_table = table
	item_id = id
	item_row = row
	item_columns = columns
	for field in columns:
		var label = label_scn.instantiate()
		label.text = field.capitalize()
		container.add_child(label)

		var lineEdit = field_scn.instantiate()
		lineEdit.text = str(row[field]) if row[field] else ""
		container.add_child(lineEdit)

		var spacer = separator.instantiate()
		container.add_child(spacer)

		colorrect.gui_input.connect(_input_event)

func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		child.queue_free()  # This will delete the child from memory

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


func _on_cancel_btn_pressed() -> void:
	visible = false


func _on_save_btn_pressed() -> void:
	var index = 0
	var db = AssignDB.db
	const sql = "UPDATE {0} SET {1}='{2}' WHERE {3} = '{4}'"
	var sql_stmt
	for field in container.get_children():
		if field is LineEdit:
			print("Node:", item_row[item_id], item_columns[index], field.text)
			sql_stmt = sql.format([db_table, item_columns[index], field.text, item_id, item_row[item_id]])
			print(sql_stmt)
			db.query(sql_stmt)
			index += 1
	emit_signal("data_changed")
	visible = false
			
