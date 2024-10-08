extends Control

var file_dialog = preload("res://UI/file_dialog_save_as.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Save as called")
	var dialog_node : FileDialog = file_dialog.instantiate()
	dialog_node.visible = true   
	dialog_node.file_selected.connect(_on_file_dialog_file_selected)
	


func _on_file_dialog_file_selected(path : String) -> void:
	var file_path = path + ".db"
	print("File selected: ", path)
	# Close current DB
	# Make a backup and save it into new path
	var result = _save_db_as(file_path)
	if !result:
		%MsgLabel.text = "Could not save DB\n."
		%ErrorMsg.text = "Status: " + AppDB.db.error_message

	AppDB.db.close_db()
	AppDB.db.path = file_path
	result = AppDB.db.open_db()
	if !result:
		%MsgLabel.text = "Could not open new cycle."
		%ErrorMsg.text = "Status: " + AppDB.db.error_message
	else:
		%MsgLabel.text = "Ready: " + file_path
		GlobalVars.file_path = file_path
		Utils.save_user_prefs()


func _save_db_as(new_file_path: String) -> bool:
	var result = AppDB.db.backup_to(new_file_path)

	if !result:
		%MsgLabel.text = "Could not save DB\n."
		%ErrorMsg.text = "Status: " + AppDB.db.error_message
		return false

	print("Database saved to ", new_file_path)
	return true