extends Control

class_name Row

# Unique ID for the row (same as db id)
var row_id
@onready var td = get_node("%TDLabel")
var style_normal = preload("res://themes/style_td_normal.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Render the row inside a grid
func render(id, row, fields, grid) -> void:
	row_id = id
	for field in fields:
		var label : Label = Label.new()
		label.add_theme_stylebox_override("normal", style_normal)
		label.text = str(row[field]) if row[field] else ""
		print(label.text)
		grid.add_child(label)

