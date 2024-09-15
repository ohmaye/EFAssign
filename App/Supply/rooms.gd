extends Supply

const COLUMN_NAMES  = Constants.ROOM_COLUMN_NAMES
const KEY = Constants.ROOM_KEY

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM rooms ORDER BY name")

	# If there are no results, return
	if not result:
		return

	var query_info = QueryInfo.new("rooms", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)