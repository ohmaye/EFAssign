extends Control

func _ready():
	print("Teachers UI Ready")
	var db = AssignDB.db
	var result = db.query("SELECT * FROM 'teachers'")
	var grid = $ScrollContainer/GridContainer
	grid.columns = db.query_result[0].size()
	for column in db.query_result[0]:
		var label = Label.new()
		label.visible_characters = 12
		label.text = column
		grid.add_child(label)
	for row in db.query_result:
		for field in row:
			var label = Label.new()
			label.visible_characters = 48
			label.text = row[field] if row[field] else ""
			grid.add_child(label)


func _on_file_dialog_file_selected(path: String) -> void:
	print(path)
	var file = FileAccess.open(path, FileAccess.READ)
	var grid = $ScrollContainer/GridContainer
#	Get Header
	var header = file.get_csv_line(",")
	grid.columns = header.size()
	for column in header:
		var label = Label.new()
		label.visible_characters = 12
		label.text = column
		grid.add_child(label)
		
	while not file.eof_reached():
		var row = file.get_csv_line(",")
		for field in row:
			var label = Label.new()
			label.visible_characters = 12
			label.text = field
			grid.add_child(label)
		
