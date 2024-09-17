extends Tree

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM demand WHERE program IN ('%s', '%s') ORDER BY firstName, lastName"

func _ready():
	# GlobalVars.intensive_checkbox.disabled = false
	# GlobalVars.general_checkbox.disabled = false

	var intensive = "Intensive" if true else ""
	var general = "General" if true else ""
	var sql_stmt = sql % [intensive, general]
	
	var db = AssignDB.db
	var result = db.query(sql_stmt)

	# Get Courses
	const sql_unique_courses = "SELECT DISTINCT course_code FROM studentpreferences ORDER BY course_code"
	var has_courses = db.query(sql_unique_courses)
	var courses = db.query_result
	print("Courses: ", courses)



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
		item.set_text(0, course["course_code"])
		item.set_text(1, "xxx")
		item.set_text(2, "yyy")
		# Get Levels
		var sql_unique_levels = "SELECT DISTINCT level FROM studentpreferences WHERE course_code = '%s' ORDER BY level" % course["course_code"]
		var has_levels = db.query(sql_unique_levels)
		var levels = db.query_result
		for level in levels:
			var child_item = create_item(item)
			child_item.set_text(1,level["level"])
	
	# Add a child item to Alice
	var alice_item = root.get_first_child()
	var child_item = create_item(alice_item)
	child_item.set_text(0, "Daughter")
	child_item.set_text(1, "5")
	child_item.set_text(2, "Student")
