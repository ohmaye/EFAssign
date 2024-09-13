extends Control

const COLUMN_NAMES  = Constants.TEACHER_COLUMN_NAMES
const KEY = Constants.TEACHER_KEY

func _ready():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("teachers", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)

	Signals.data_changed.connect(_on_data_changed)
	print("Signals connected", Signals.get_signal_connection_list("data_changed"))


func _on_data_changed():
	print("Teachers data changed")




func _exit_tree():
	Signals.data_changed.disconnect(_on_data_changed)