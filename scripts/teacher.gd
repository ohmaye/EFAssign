# File: res://scripts/Teacher.gd
extends Assign

class_name Teacher  # Registers the class globally as 'Teacher'

static var SHOW_COLUMNS = ["name", "active", "nameJP", "email", "note"]
static var FILTERS = {"name": "", "nameJP": "", "email": "", "note": ""}
static var COLUMN_RATIOS = [1,1,1,2,0.2]
static var KEY = "teacher_id"
static var TABLE = "teachers"

# Class Properties
var teacher_id: String
var name: String
var nameJP: String
var email: String
var note: String
var active: bool

# Custom Constructor
func _init(data: Dictionary = {}):
	# print("Teacher: ", data)
	teacher_id = data.get("teacher_id") if data.get("teacher_id") else ""
	name = data.get("name") if data.get("name") else ""
	nameJP = data.get("nameJP") if data.get("nameJP") else ""
	email = data.get("email") if data.get("email") else ""
	note = data.get("note") if data.get("note") else ""
	active = true if data.get("active") else false
