extends Controller

var query_info 

var popup = preload("res://UI/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_rooms = AppDB.db_get("SELECT * FROM rooms ORDER BY name")
	var rooms : Array[Room] = []
	for db_room in db_rooms:
		rooms.append(Room.new(db_room))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % rooms.size()

	query_info = QueryInfo.new("rooms", Room.SHOW_COLUMNS, rooms, Room.KEY )
	
	# $Table.render(query_info)
	%TreeTable.render(Room, rooms)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO rooms (room_id)  VALUES ('{0}')"

	var row = {"room_id": id}
	for column in Room.SHOW_COLUMNS:
		row[column] = ""

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
		Signals.data_changed.emit()
