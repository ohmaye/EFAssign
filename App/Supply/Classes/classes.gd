extends Controller

@onready var _class = ClassesView

var popup = preload("res://UI/tree_table/popup/popup.tscn")


func _ready():
	# Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_classes = AppDB.db_get("SELECT * FROM classes_view")
	var classes : Array[ClassesView] = []
	for a_class in db_classes:
		classes.append(ClassesView.new(a_class))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % db_classes.size()

	%TreeTable.render(_class, classes)


func _on_data_changed():
	_load_data_and_render()
