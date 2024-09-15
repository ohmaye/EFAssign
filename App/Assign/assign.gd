extends Supply

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM demand WHERE program IN ('%s', '%s') ORDER BY firstName, lastName"

func render():
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = false
	GlobalVars.general_checkbox.disabled = false

	var intensive = "Intensive" if GlobalVars.intensive_checkbox.button_pressed else ""
	var general = "General" if GlobalVars.general_checkbox.button_pressed else ""
	var sql_stmt = sql % [intensive, general]
	
	var db = AssignDB.db
	var result = db.query(sql_stmt)

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)

	



