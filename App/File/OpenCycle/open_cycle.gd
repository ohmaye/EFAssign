extends Control

var file_dialog = preload("res://UI/file_dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var dialog_node = file_dialog.instantiate()
	dialog_node.visible = true
	dialog_node.file_selected.connect(_on_file_dialog_file_selected)




func _on_file_dialog_file_selected(path : String) -> void:
	print("File selected: ", path)
	AppDB.db.path = path
	AppDB.db.close_db()
	var result = AppDB.db.open_db()
	if !result:
		%MsgLabel.text = "Could not open cycle."
	else:
		%MsgLabel.text = "Ready: " + path
		GlobalVars.file_path = path
		Utils.save_user_prefs()

