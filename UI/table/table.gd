extends Control

# Containers for the table header & filter & data
@onready var header_grid = %HeaderGridContainer
@onready var filter_grid = %FilterGridContainer
@onready var rows_grid = %RowsGridContainer

# Node for data
var cell = preload("res://UI/table/cell.tscn")
var filter = preload("res://UI/table/filter.tscn")

# Styleboxes
var style_header = preload("res://UI/table/styles/style_cell_header.tres")
var style_normal = preload("res://UI/table/styles/style_cell_normal.tres")

var popup = preload("res://UI/popup/popup.tscn")

func render(_query_info : QueryInfo):
	# Clear the grid
	Utils.free_all_children(header_grid)
	Utils.free_all_children(filter_grid)
	Utils.free_all_children(rows_grid)
	
	var count = _query_info.columns.size()
	header_grid.columns = count
	filter_grid.columns = count
	rows_grid.columns = count

	var popup_node = popup.instantiate()
	popup_node.visible = false
	add_child(popup_node)

	# Add the headers
	for field in _query_info.columns:
		var node = cell.instantiate()
		node.add_theme_stylebox_override("normal", style_header)
		node.text = field
		header_grid.add_child(node)

	# Add the filters
	for field in _query_info.columns:
		var node = filter.instantiate()
		# node.add_theme_stylebox_override("normal", style_normal)
		node.text = ""
		header_grid.add_child(node)

	# Add the rows
	for row in _query_info.rows:
		var row_node = Row.new()
		row_node.render(row, _query_info, rows_grid, cell, popup_node)
