extends Controller

const COLUMN_NAMES  = Constants.TEACHER_COLUMN_NAMES
const KEY = Constants.TEACHER_KEY
var query_info 

var popup = preload("res://UI/popup/popup.tscn")

func render():
	var db = AssignDB.db
	var result = db.query("SELECT * FROM teachers ORDER BY name")

	# If there are no results, return
	if not result:
		return
		
	query_info = QueryInfo.new("teachers", COLUMN_NAMES, db.query_result, KEY )

	Signals.add_new.connect(_add_new)
	
	$Table.render(query_info)

func _add_new():
	var popup_node = popup.instantiate()
	add_child(popup_node)
	
	var db = AssignDB.db
	var id = Utilities.uuid.v4()
	var sql_stmt = "INSERT INTO teachers (teacher_id)  VALUES ('{0}')"

	var row = {"teacher_id": id}
	for column in COLUMN_NAMES:
		row[column] = ""

	var result = db.query(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
