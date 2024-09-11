extends Control

const FIELD_NAMES  = Constants.SURVEY_FIELD_NAMES
const ID = Constants.SURVEY_ID

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM survey")

	# If there are no results, return
	if not result:
		return

	$Table.render(ID, FIELD_NAMES, db.query_result )