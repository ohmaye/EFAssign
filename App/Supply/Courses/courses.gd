extends Controller

@onready var _class = Course

var popup = preload("res://UI/tree_table/popup/popup.tscn")

func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var courses = AppDB.db_get_objects(_class, "SELECT * FROM courses ORDER BY code")

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % courses.size()
	
	%TreeTable.render(_class, courses)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO courses (course_id)  VALUES ('%s')" % id

	var course = Course.new({"course_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(course, _class)
		popup_node.visible = true	
		Signals.emit_data_changed()
