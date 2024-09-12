extends Control

const COLUMN_NAMES  = Constants.COURSE_COLUMN_NAMES
const KEY = Constants.COURSE_KEY

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM courses")

	# If there are no results, return
	if not result:
		return

	var query = QueryInfo.new("courses", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query)