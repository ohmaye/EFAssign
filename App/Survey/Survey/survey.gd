extends Controller

@onready var _class = Survey

var popup = preload("res://UI/tree_table/popup/popup.tscn")

const sql = "SELECT * FROM survey ORDER BY firstName, lastName"

func _ready():
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_surveys = AppDB.db_get(sql)
	var surveys : Array[Survey] = []
	for survey in db_surveys:
		surveys.append(Survey.new(survey))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % surveys.size()
		
	%TreeTable.render(_class, surveys)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO survey (student_id)  VALUES ('%s')" % id

	var survey = Survey.new({"student_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(survey, _class)
		popup_node.visible = true	
		Signals.data_changed.emit()