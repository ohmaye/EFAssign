extends OptionButton

var selected_room_id = ""

const sql_rooms_for_class = """
	SELECT * FROM rooms WHERE active = 1
"""
func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _render(row):
	var empty_room = {"room_id": "", "name": "?", "capacity": 0}
	var rooms = [empty_room] + AppDB.db_get(sql_rooms_for_class)

	var index = 0
	for room in rooms:
		var choice = room.name + "  (" + str(room.capacity) + ")"
		add_item( choice, index)
		set_item_metadata(index, room.room_id)
		if room.room_id == row["room_id"]:
			select( get_item_count() - 1)
			selected_room_id = room.room_id
		index += 1

func _on_item_selected(index):
	selected_room_id = get_item_metadata(index)
	print("Selected Course ID:", selected_room_id, "Index: ", index)
