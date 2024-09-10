extends Control

# Containers for the table header & filter & data
@onready var header_grid = get_node("%HeaderGridContainer")
@onready var filter_grid = get_node("%FilterGridContainer")
@onready var rows_grid = get_node("%RowsGridContainer")

# Node for data label
@onready var td = get_node("%TDLabel")

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
		print("Nothing")
		return

	# Add the headers
	for field in FIELD_NAMES:
		var label = td.duplicate()
		label.visible = true
		label.text = field.capitalize()
		header_grid.add_child(label)

	# # Add the rows
	# for row in db.query_result:
	# 	var trow = tr_element.instantiate()
	# 	trow.render(row[ID], row, FIELD_NAMES, grid)
