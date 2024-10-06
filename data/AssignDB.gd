extends Node

class_name AppDB

static var db : SQLite = null
const verbosity_level : int = SQLite.NORMAL

static func setup_db() -> void:
	db = SQLite.new()
	# db.verbosity_level = verbosity_level
	print("Called Init")

	# Utils.save_user_prefs()
	Utils.load_user_prefs()
	print("Loaded path from Prefs: ", GlobalVars.file_path)

	var result : bool = false
	if GlobalVars.file_path != "":
		db.path = GlobalVars.file_path
		result = db.open_db()

	if !result:
		print("Opening Default DB")
		db.path = GlobalVars.default_path
		result = db.open_db()
		if !result:
			print("Could not open DB")

	DisplayServer.window_set_title((db.path).get_file())

# func _exit_tree() -> void:
# 	db.close_db()


static func db_get(sql : String) -> Array:
	var result = db.query(sql)
	if not result:
		return []
	else:
		return db.query_result


static func db_run(sql : String) -> bool:
	var result = db.query(sql)
	# print("Run query: ", sql)
	return result
