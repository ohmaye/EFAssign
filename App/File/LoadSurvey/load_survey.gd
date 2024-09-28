extends Controller

var file_dialog = preload("res://UI/file_dialog.tscn")

func _ready() -> void:
	var file_dialog_node = file_dialog.instantiate()
	file_dialog_node.visible = true
	file_dialog_node.file_selected.connect(_file_selected)


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

