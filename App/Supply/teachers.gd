extends Supply

const COLUMN_NAMES  = Constants.TEACHER_COLUMN_NAMES
const KEY = Constants.TEACHER_KEY

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("teachers", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)




