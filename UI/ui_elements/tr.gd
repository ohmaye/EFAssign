extends Control

var row_id
var row_labels : = []
var popup_panel

# Control for table data
var td = preload("res://UI/ui_elements/td.tscn")
var edit_popup = preload("res://UI/ui_elements/edit_popup.tscn")

# Styles for table data
var style_hover = preload("res://themes/style_td_hover.tres")
var style_normal = preload("res://themes/style_td_normal.tres")

# Render the row inside a grid
func render(id, row, fields, grid) -> void:
	row_id = id
	# popup_panel = grid.get_node("/root/Main/PopupPanel")
	popup_panel = edit_popup.instantiate()
	grid.add_child(popup_panel)
	for field in fields:
		var label : Label = td.instantiate()
		# label.visible_characters = 48
		label.text = row[field] if row[field] else ""
		grid.add_child(label)
		label.mouse_entered.connect(_on_mouse_entered)
		label.mouse_exited.connect(_on_mouse_exited)
		label.gui_input.connect(_input_event)
		row_labels.append(label)


func _on_mouse_entered() -> void:
	for label : Label in row_labels:
		label.add_theme_stylebox_override("normal", style_hover)

func _on_mouse_exited() -> void:
	for label : Label in row_labels:
		label.add_theme_stylebox_override("normal", style_normal)

func _input_event(event):
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("Label clicked!")
		# var editor : PopupPanel = edit_popup.instantiate()
		print("PopupPanel: ", popup_panel)
		popup_panel.show()

