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
	

	# Set up the columns
	set_columns(5)
	# set_column_titles_visible(true)
	
	# Set column titles
	set_column_title(0, "Course")
	set_column_title(1, "Level")
	set_column_title(2, "Student")
	set_column_title(3, "Choice")
	set_column_title(4, "Total")
	
	# Create the root item
	var root = create_item()
	
	# Get Courses
	var db = AssignDB.db
	const sql_courses = "SELECT DISTINCT course_code FROM studentpreferences ORDER BY course_code"
	db.query(sql_courses)
	var courses = db.query_result
	# Populate the tree with items
	for course in courses:
		var course_entry = root.create_child()
		course_entry.set_text(0, course["course_code"])
		course_entry.set_text(4, "1")
		# Get Levels
		var sql_levels = "SELECT DISTINCT level FROM studentpreferences WHERE course_code = '%s' ORDER BY level" % course["course_code"]
		db.query(sql_levels)
		var levels = db.query_result
		for level in levels:
			var level_entry = course_entry.create_child()
			level_entry.set_text(0,level["level"])		
			level_entry.set_text(1,level["level"])		
			var sql_students = "SELECT DISTINCT student_id, firstName, lastName FROM studentpreferences WHERE course_code = '%s' AND level = '%s' ORDER BY level" % [course["course_code"], level["level"]]
			db.query(sql_students)
			var students = db.query_result
			for student in students:
				var str_entry = level_entry.create_child()
				str_entry.set_text(2, student["firstName"] + student["lastName"])
				str_entry.set_text(3, "Mon01")
				str_entry.set_text(4,"88")
	
	# Add a child item to Alice
	# var alice_item = root.get_first_child()
	# var child_item = create_item(alice_item)
	# child_item.set_text(0, "Daughter")
	# child_item.set_text(1, "5")
	# child_item.set_text(2, "Student")
