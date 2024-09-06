extends Node

class_name AssignDB

static var db : SQLite = null
static var db_name := "res://data/EFAssign.db"

const verbosity_level : int = SQLite.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = db_name
	db.verbosity_level = verbosity_level
	# Open the database using the db_name found in the path variable
	db.open_db()

