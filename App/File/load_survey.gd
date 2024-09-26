extends Supply

const COLUMN_NAMES  = Constants.SURVEY_COLUMN_NAMES
const KEY = Constants.SURVEY_KEY

func render():
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = true
	GlobalVars.general_checkbox.disabled = true

	var db = AssignDB.db
	var result = db.query("SELECT * FROM survey")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("survey", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)