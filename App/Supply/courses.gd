extends Supply

const COLUMN_NAMES  = Constants.COURSE_COLUMN_NAMES
const KEY = Constants.COURSE_KEY

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM courses ORDER BY code")

	# If there are no results, return
	if not result:
		return

	var query_info = QueryInfo.new("courses", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)