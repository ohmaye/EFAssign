extends Controller

var file_dialog = preload("res://UI/file_dialog.tscn")

const COLUMN_NAMES  = Constants.SURVEY_COLUMN_NAMES
const KEY = Constants.SURVEY_KEY

func _ready():
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = true
	GlobalVars.general_checkbox.disabled = true

	var db = AssignDB.db
	var result = db.query("SELECT * FROM survey")

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("survey", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)

# func _on_load_survey_btn_pressed() -> void:
# 	var load_survey_scene = preload("res://App/file/LoadSurvey/load_survey.tscn")
# 	var file_dialog_node = file_dialog.instantiate()
# 	file_dialog_node.visible = true
# 	file_dialog_node.file_selected.connect(_file_selected)
# 	_change_scene(load_survey_scene)

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
