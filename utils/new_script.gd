extends Tree

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql_unique_courses = "SELECT DISTINCT code FROM courses ORDER BY code"
const sql = "SELECT * FROM demand WHERE program IN ('%s', '%s') ORDER BY firstName, lastName"

func _ready():
	# GlobalVars.intensive_checkbox.disabled = false
	# GlobalVars.general_checkbox.disabled = false

	var intensive = "Intensive" if true else ""
	var general = "General" if true else ""
	var sql_stmt = sql % [intensive, general]
	
	var db = AssignDB.db
	var result = db.query(sql_stmt)

	var courses = db.query(sql_unique_courses)
	courses = db.query_result

	# If there are no results, return
	if not result:
		return

	# Set up the columns
	set_columns(3)
	set_column_titles_visible(true)
	
	# Set column titles
	set_column_title(0, "Course")
	set_column_title(1, "Level")
	set_column_title(2, "Name")
	
	# Create the root item
	var root = create_item()
	
	# Sample data
	var data = [
		{"name": "Alice", "age": "30", "occupation": "Engineer"},
		{"name": "Bob", "age": "25", "occupation": "Designer"},
		{"name": "Charlie", "age": "35", "occupation": "Manager"}
	]
	
	# Populate the tree with items
	for course in courses:
		var item = create_item(root)
		item.set_text(0, course["code"])
		item.set_text(1, "xxx")
		item.set_text(2, "yyy")
	
	# Add a child item to Alice
	var alice_item = root.get_first_child()
	var child_item = create_item(alice_item)
	child_item.set_text(0, "Daughter")
	child_item.set_text(1, "5")
	child_item.set_text(2, "Student")
