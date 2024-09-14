extends Supply

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM demand ORDER BY firstName, lastName")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)
