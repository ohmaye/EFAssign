extends Node

class_name AssignDB

static var db : SQLite = null

const verbosity_level : int = SQLite.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = GlobalVars.db_name
	db.verbosity_level = verbosity_level
	# Open the database using the db_name found in the path variable
	db.open_db()

func _exit_tree() -> void:
	db.close_db()