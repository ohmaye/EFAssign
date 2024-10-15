extends Controller

@onready var _class = ClassesView

var popup = preload("res://UI/tree_table/popup/popup.tscn")


func _ready():
	# Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var classes = AppDB.db_get_objects(_class, "SELECT * FROM classes_view")

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % classes.size()

	%TreeTable.render(_class, classes)


func _on_data_changed():
	_load_data_and_render()
