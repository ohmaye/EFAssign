extends Supply

const COLUMN_NAMES  = Constants.TIMESLOT_COLUMN_NAMES
const KEY = Constants.TIMESLOT_KEY

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM timeslots")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("timeslots", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)