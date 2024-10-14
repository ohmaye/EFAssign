extends Control

var default_path : String = "res://data/EFAssign.db"

var file_path : String :
	set(path):
		file_path = path
		DisplayServer.window_set_title(path.get_file())

var font_size : int :
	set(size):
		font_size = size
		