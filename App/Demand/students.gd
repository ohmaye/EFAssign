extends Control

const COLUMN_NAMES  = Constants.STUDENT_COLUMN_NAMES
const KEY = Constants.STUDENT_KEY

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM students")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("teachers", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)
