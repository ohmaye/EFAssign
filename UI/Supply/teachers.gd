extends Control

const FIELD_NAMES = ["name", "nameJP", "email", "active"]

# Control for table header
var th = preload("res://UI/ui_elements/th.tscn")

# Control for table row
var tr = preload("res://UI/ui_elements/tr.tscn")

# Control for table data
var td = preload("res://UI/ui_elements/td.tscn")

func _ready():
	var db = AssignDB.db
	print("Teachers UI Ready")
	var result = db.query("SELECT * FROM 'teachers'")
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
		label.visible_characters = 48
		label.text = field.capitalize()
		header_grid.add_child(label)

	# Add the rows
	for row in db.query_result:
		var trow = tr.instantiate()
		trow.render(row["id"], row, FIELD_NAMES, grid)

	# # Add the data
	# for row in db.query_result:
	# 	for field in FIELD_NAMES:
	# 		var label = td.instantiate()
	# 		label.visible_characters = 48
	# 		label.text = row[field] if row[field] else ""
	# 		grid.add_child(label)

		
