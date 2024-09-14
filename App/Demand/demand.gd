extends Supply

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

func render():
	print("Render Demand")
	var db = AssignDB.db
	var sql = "SELECT * FROM demand WHERE program IN ('{0}', '{1}') ORDER BY firstName, lastName"
	var intensive = "Intensive" if GlobalVars.intensive_checkbox.button_pressed else ""
	var general = "General" if GlobalVars.general_checkbox.button_pressed else ""
	var sql_stmt = sql.format([intensive, general])
	print("SQL: ", sql_stmt)
	var result = db.query(sql_stmt)

	
	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)

	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = false
	GlobalVars.general_checkbox.disabled = false
	# Listen to data_changed signal (coming from main when checkbox toggled)
	# Signals.intensive_toggled.connect(func(): Signals.data_changed.emit())
	# Signals.general_toggled.connect(func(): Signals.data_changed.emit())


# Use the onready keyword to fetch the node after the scene is loaded


