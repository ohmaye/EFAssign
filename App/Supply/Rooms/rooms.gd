extends Controller

@onready var _class = Room

var popup = preload("res://UI/tree_table/popup/popup.tscn")


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

	%TreeTable.render(_class, rooms)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO rooms (room_id)  VALUES ('%s')" % id

	var room = Room.new({"room_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(room, _class)
		popup_node.visible = true	
		Signals.data_changed.emit()
