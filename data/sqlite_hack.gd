extends Node


# HACK: workaround 4.4 issue

func _init() -> void:
	var config_file = "res://.godot/extension_list.cfg"
	var content:String = "res://addons/godot-sqlite/gdsqlite.gdextension"
	var file = FileAccess.open(config_file, FileAccess.WRITE)
	file.store_string(content)
	print("Sqlite plugin configuration file created")