extends Controller

@onready var _class = TimeSlot

var popup = preload("res://UI/tree_table/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_timeslots = AppDB.db_get("SELECT * FROM timeslots ORDER BY weekday, start_time")
	var timeslots : Array[TimeSlot] = []
	for db_timeslot in db_timeslots:
		timeslots.append(TimeSlot.new(db_timeslot))
		
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % timeslots.size()
	
	%TreeTable.render(_class, timeslots)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO timeslots (timeslot_id)  VALUES ('%s')" % id

	var timeslot = TimeSlot.new({"timeslot_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(timeslot, _class)
		popup_node.visible = true	
		Signals.data_changed.emit()
