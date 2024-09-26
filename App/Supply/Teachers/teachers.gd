extends Controller

const COLUMN_NAMES  = Constants.TEACHER_COLUMN_NAMES
const KEY = Constants.TEACHER_KEY
var query_info 

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
	var popup = get_node("/root/Main/Popup")
	var db = AssignDB.db
	var id = Utilities.uuid.v4()
	var sql_stmt = "INSERT INTO teachers (teacher_id)  VALUES ('{0}')"

	var row = {"teacher_id": id}
	for column in COLUMN_NAMES:
		row[column] = ""

	var result = db.query(sql_stmt.format([id]))

	if result:
		popup.render(row, query_info)
		popup.visible = true	
