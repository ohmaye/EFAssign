extends Controller

const COLUMN_NAMES = Constants.SURVEY_COLUMN_NAMES
const KEY = Constants.SURVEY_KEY

var file_dialog = preload("res://UI/file_dialog_csv.tscn")

func _ready() -> void:
	var dialog_node : FileDialog = file_dialog.instantiate()
	dialog_node.visible = true
	dialog_node.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog_node.file_selected.connect(_file_selected)


## Handle file selection
##
## Selected a file path for the survey to load.

func _file_selected(path : String):
	var survey : Array = []
	var file = FileAccess.open(path, FileAccess.READ)
	print("File: ", file)

	if file == null:
		print("Couldn't open the file")
		return

	# Read the header
	file.get_csv_line(",")

	# Read the CSV file
	while not file.eof_reached():
		var csvRow = file.get_csv_line(",")
		var id = Utils.uuid.v4()
		var row = [id]
		for field in csvRow:
			row.append(field)
		survey.append(row)

	# Clear the current survey table
	AppDB.db.query("DELETE FROM survey")
	# Insert rows into table "survey"
	var columns = ", ".join(COLUMN_NAMES)
	for row in survey:
		var values = []
		for v in row:
			values.append('"%s"' % v)
		var values_str = ", ".join(values)
		var sql = "INSERT INTO survey ({0}) VALUES ({1})".format([columns, values_str])
		AppDB.db.query(sql)
		
	print("Loaded Survey Msgs")


