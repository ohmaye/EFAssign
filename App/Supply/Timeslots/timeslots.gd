extends Controller

var query_info 

var popup = preload("res://UI/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var timeslots = AppDB.db_get("SELECT * FROM timeslots ORDER BY weekday, start_time")
		
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % timeslots.size()

	
	query_info = QueryInfo.new("timeslots", TimeSlot.SHOW_COLUMNS, timeslots, TimeSlot.KEY )
	
	$Table.render(query_info)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO timeslots (timeslot_id)  VALUES ('{0}')"

	var row = {"timeslot_id": id}
	for column in TimeSlot.SHOW_COLUMNS:
		row[column] = ""

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
		Signals.data_changed.emit()
