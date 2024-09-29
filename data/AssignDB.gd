extends Control

class_name AssignDB

static var db : SQLite = null
const verbosity_level : int = SQLite.NORMAL

func _ready() -> void:
	DisplayServer.window_set_title(db.path)

func _init():
	db = SQLite.new()
	db.verbosity_level = verbosity_level
	print("Called Init")

	# Utils.save_user_prefs()
	Utils.load_user_prefs()
	print("Loaded Prefs: ", GlobalVars.file_path)

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

func _exit_tree() -> void:
	db.close_db()


func db_get(sql : String) -> Array:
	var result = db.query(sql)
	if not result:
		return []
	else:
		return db.query_result
