extends Control

var tr_data = {}
var grid
var row_id

# Control for table data
var td = preload("res://UI/ui_elements/td.tscn")

# Called when the node enters the scene tree for the first time.
func render(row, fields, grid) -> void:
	row_id = row["id"]
	print(row_id)
	for field in fields:
		var label = td.instantiate()
		label.visible_characters = 48
		label.text = row[field] if row[field] else ""
		grid.add_child(label)

