extends Controller

@onready var _class = Teacher

var popup = preload("res://UI/tree_table/popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_teachers = AppDB.db_get("SELECT * FROM teachers ORDER BY name COLLATE NOCASE")
	var teachers = []
	for teacher in db_teachers:
		teachers.append(Teacher.new(teacher))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % teachers.size()
		
	%TreeTable.render(_class, teachers)

func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO teachers (teacher_id)  VALUES ('%s')" % id

	var teacher = Teacher.new({"teacher_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(teacher, _class)
		popup_node.visible = true	
		Signals.data_changed.emit()
