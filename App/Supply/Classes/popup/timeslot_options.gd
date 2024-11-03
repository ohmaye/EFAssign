extends OptionButton

var selected_timeslot_id = ""

const sql_timeslots_for_class = """
	SELECT * FROM timeslots WHERE active = 1
"""
func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _render(row):
	var timeslots = AppDB.db_get(sql_timeslots_for_class)

	var index = 0
	for timeslot in timeslots:
		var choice = timeslot.weekday + " " + timeslot.start_time + " - " + timeslot.end_time
		add_item( choice, index)
		set_item_metadata(index, timeslot.timeslot_id)
		if timeslot.timeslot_id == row["timeslot_id"]:
			select( get_item_count() - 1)
		index += 1

func _on_item_selected(index):
	selected_timeslot_id = get_item_metadata(index)
	print("Selected Course ID:", selected_timeslot_id, "Index: ", index)
