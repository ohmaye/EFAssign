extends ColorRect

var file_dialog = preload("res://UI/file_dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _change_scene(scene : PackedScene):
	var container = %FileContent
	Utilities.remove_all_children(container)
	var scene_node = scene.instantiate()
	scene_node.call_deferred("render")	
	container.add_child(scene_node)


## FILE TAB
##
## Handlers for Open, New, Save, Save As, Load Survey, and Quit

func _on_open_btn_pressed() -> void:
	var open_scene = preload("res://App/demand/Survey/survey.tscn")
	_change_scene(open_scene)

func _on_new_btn_pressed() -> void:
	var new_scene = preload("res://App/demand/Students/students.tscn")
	_change_scene(new_scene)

func _on_save_btn_pressed() -> void:
	var save_scene = preload("res://App/demand/ByStudent/by_student.tscn")
	_change_scene(save_scene)

func _on_save_as_btn_pressed() -> void:
	var save_as_scene = preload("res://App/demand/ByLevel/by_level.tscn")
	_change_scene(save_as_scene)

func _on_load_survey_btn_pressed() -> void:
	var load_survey_scene = preload("res://App/file/LoadSurvey/load_survey.tscn")
	var file_dialog_node = file_dialog.instantiate()
	file_dialog_node.visible = true
	file_dialog_node.file_selected.connect(_file_selected)
	_change_scene(load_survey_scene)

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

func _on_quit_btn_pressed() -> void:
	print("Calling quit")
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

