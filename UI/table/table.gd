extends Control

# Containers for the table header & filter & data
@onready var header_grid = get_node("%HeaderGridContainer")
@onready var filter_grid = get_node("%FilterGridContainer")
@onready var rows_grid = get_node("%RowsGridContainer")

# Node for cell data
var td = preload("res://UI/table/cell.tscn")
var filter = preload("res://UI/table/filter.tscn")

var style_normal = preload("res://themes/style_td_normal.tres")

const FIELD_NAMES  = Constants.TEACHER_FIELD_NAMES
const ID = Constants.TEACHER_ID

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers")
	header_grid.columns = FIELD_NAMES.size()
	filter_grid.columns = FIELD_NAMES.size()
	rows_grid.columns = FIELD_NAMES.size()

	# If there are no results, return
	if not result:
		return

	# Add the headers
	for field in FIELD_NAMES:
		var label = td.instantiate()
		label.add_theme_stylebox_override("normal", style_normal)
		label.text = field.capitalize()
		header_grid.add_child(label)

	# Add the filters
	for field in FIELD_NAMES:
		var label = filter.instantiate()
		label.add_theme_stylebox_override("normal", style_normal)
		label.text = field.capitalize()
		header_grid.add_child(label)

	# Add the rows
	for row in db.query_result:
		var trow = Row.new()
		trow.render(row[ID], row, FIELD_NAMES, rows_grid, td)
