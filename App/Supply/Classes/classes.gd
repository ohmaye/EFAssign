extends Controller

@onready var _class = ClassesView

var popup = preload("popup/popup.tscn")


func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var classes = AppDB.db_get_objects(_class, "SELECT * FROM classes_view")

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % classes.size()

	%TreeTable.render(_class, classes)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO classes (class_id)  VALUES ('%s')" % id

	var class_ = Class_.new({"class_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(class_, _class)
		popup_node.visible = true	
		Signals.emit_data_changed()


