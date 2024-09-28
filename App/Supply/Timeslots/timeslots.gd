extends Controller

const COLUMN_NAMES  = Constants.TIMESLOT_COLUMN_NAMES
const KEY = Constants.TIMESLOT_KEY

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM timeslots ORDER BY weekday, start_time")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("timeslots", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)