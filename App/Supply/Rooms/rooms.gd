extends Controller

const COLUMN_NAMES  = Constants.ROOM_COLUMN_NAMES
const KEY = Constants.ROOM_KEY
var query_info 

var popup = preload("res://UI/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db = AppDB.db
	var result = db.query("SELECT * FROM rooms ORDER BY name")

	# If there are no results, return
	if not result:
		return

	query_info = QueryInfo.new("rooms", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var db = AppDB.db
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO rooms (room_id)  VALUES ('{0}')"

	var row = {"room_id": id}
	for column in COLUMN_NAMES:
		row[column] = ""

	var result = db.query(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
		Signals.data_changed.emit()
