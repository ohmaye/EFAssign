extends Controller

var query_info 

var popup = preload("res://UI/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_teachers = AppDB.db_get("SELECT * FROM teachers ORDER BY name")
	var teachers = []
	for teacher in db_teachers:
		teachers.append(Teacher.new(teacher))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % teachers.size()
		
	query_info = QueryInfo.new("teachers", Teacher.SHOW_COLUMNS, teachers, Teacher.KEY )
	$Table.render(query_info)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO teachers (teacher_id)  VALUES ('{0}')"

	var row = {"teacher_id": id}
	for column in Teacher.SHOW_COLUMNS:
		row[column] = ""

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
		Signals.data_changed.emit()
