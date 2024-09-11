extends Control

class_name Row

# Unique ID for the row (same as db id)
var row_id
var row_data
var row_columns
var row_labels : = []

# Styles for table data
var style_hover = preload("res://themes/style_td_hover.tres")
var style_normal = preload("res://themes/style_td_normal.tres")

# Popup for editing
var edit_popup = preload("res://UI/ui_elements/edit_popup.tscn")
static var popup_panel : PopupPanel 

# Render the row inside a grid
func render(id, row, columns, grid, td) -> void:
	row_id = id
	row_data = row
	row_columns = columns

	popup_panel = edit_popup.instantiate()
	popup_panel.visible = false
	grid.add_child(popup_panel)

	for field in columns:
		var label = td.instantiate()
		label.add_theme_stylebox_override("normal", style_normal)
		label.text = str(row[field]) if row[field] else ""
		grid.add_child(label)
		row_labels.append(label)
		label.mouse_entered.connect(_on_mouse_entered)
		label.mouse_exited.connect(_on_mouse_exited)
		label.gui_input.connect(_input_event)

func _on_mouse_entered() -> void:
	for label : Label in row_labels:
		label.add_theme_stylebox_override("normal", style_hover)

func _on_mouse_exited() -> void:
	for label : Label in row_labels:
		label.add_theme_stylebox_override("normal", style_normal)

func _input_event(event):
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		popup_panel.render(row_id, row_data, row_columns)
		popup_panel.visible = !popup_panel.visible

