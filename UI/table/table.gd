extends Control

# Containers for the table header & filter & data
@onready var header_grid = %HeaderGridContainer
@onready var filter_grid = %FilterGridContainer
@onready var rows_grid = %RowsGridContainer

# Node for cell data
var td = preload("res://UI/table/cell.tscn")
var filter = preload("res://UI/table/filter.tscn")

var style_header = preload("res://UI/table/styles/style_cell_header.tres")
var style_normal = preload("res://UI/table/styles/style_cell_normal.tres")

func render(id, columns, rows):
	var count = columns.size()
	header_grid.columns = count
	filter_grid.columns = count
	rows_grid.columns = count

	# Add the headers
	for field in columns:
		var label = td.instantiate()
		label.add_theme_stylebox_override("normal", style_header)
		label.text = field.capitalize()
		header_grid.add_child(label)

	# Add the filters
	for field in columns:
		var label = filter.instantiate()
		label.add_theme_stylebox_override("normal", style_normal)
		label.text = ""
		header_grid.add_child(label)

	# Add the rows
	for row in rows:
		var trow = Row.new()
		trow.render(id, row, columns, rows_grid, td)
