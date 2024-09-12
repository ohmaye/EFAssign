extends Control

const FIELD_NAMES = Constants.ROOM_FIELD_NAMES
const ID = Constants.ROOM_ID

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM rooms")

	# If there are no results, return
	if not result:
		return

	$Table.render(ID, FIELD_NAMES, db.query_result, "rooms" )


		
