extends Control

# Control for table header
var th = preload("res://UI/ui_elements/th.tscn")

# Control for table row
var tr_element = preload("res://UI/ui_elements/tr.tscn")

# Control for table data
var td = preload("res://UI/ui_elements/td.tscn")

const FIELD_NAMES  = Constants.TEACHER_FIELD_NAMES
const ID = Constants.TEACHER_ID

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers")
	var header_grid = $GridContainer
	var grid = $ScrollContainer/GridContainer
	grid.columns = FIELD_NAMES.size()
	header_grid.columns = FIELD_NAMES.size()

	# If there are no results, return
	if not result:
		return
	# Add the headers
	for field in FIELD_NAMES:
		var label = th.instantiate()
		label.text = field.capitalize()
		header_grid.add_child(label)

	# Add the rows
	for row in db.query_result:
		var trow = tr_element.instantiate()
		trow.render(row[ID], row, FIELD_NAMES, grid)


		
