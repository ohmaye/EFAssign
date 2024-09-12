extends Control

const FIELD_NAMES  = Constants.TEACHER_FIELD_NAMES
const ID = Constants.TEACHER_ID

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers")

	# If there are no results, return
	if not result:
		return

	connect("data_changed", _on_data_changed)

	$Table.render(ID, FIELD_NAMES, db.query_result, "teachers" )

func _on_data_changed():
	print("Data changed, at teachers...")
