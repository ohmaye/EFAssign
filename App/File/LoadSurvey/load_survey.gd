extends Controller

var file_dialog = preload("res://UI/file_dialog.tscn")
var load_survey_scene = preload("res://App/file/LoadSurvey/load_survey.tscn")

const COLUMN_NAMES  = Constants.SURVEY_COLUMN_NAMES
const KEY = Constants.SURVEY_KEY
var query_info 

var popup = preload("res://UI/popup/popup.tscn")


func _ready() -> void:
	var file_dialog_node = file_dialog.instantiate()
	file_dialog_node.visible = true
	file_dialog_node.file_selected.connect(_file_selected)


func _load_data_and_render():
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = true
	GlobalVars.general_checkbox.disabled = true

	var db = AssignDB.db
	var result = db.query("SELECT * FROM survey")

	# If there are no results, return
	if not result:
		return
		
	query_info = QueryInfo.new("survey", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var db = AssignDB.db
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO survey (survey_id)  VALUES ('{0}')"

	var row = {"survey_id": id}
	for column in COLUMN_NAMES:
		row[column] = ""

	var result = db.query(sql_stmt.format([id]))

	if result:
		popup_node.render(row, query_info)
		popup_node.visible = true	
		Signals.data_changed.emit()


## Handle file selection
##
## Selected a file path for the survey to load.

func _file_selected(path : String):
	var survey : Array
	var file = FileAccess.open(path, FileAccess.READ)
	print("File: ", file)

	if file == null:
		print("Couldn't open the file")
		return

	while not file.eof_reached():
		var csvRow = file.get_csv_line(",")
		var row = []
		for field in csvRow:
			row.append(field)
		survey.append(row)
	print("Survey: ", survey)

