# File: res://scripts/Teacher.gd
extends Assign

class_name Teacher  # Registers the class globally as 'Teacher'

static var SHOW_COLUMNS = ["name", "nameJP", "email", "note", "active"]
static var COLUMN_RATIOS = [1,1,1,2,0.2]
static var KEY = "teacher_id"

# Class Properties
var teacher_id: String
var name: String
var nameJP: String
var email: String
var note: String
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
	print("Teacher: ", data)
	teacher_id = data.get("teacher_id", "")
	name = data.get("name", "")
	nameJP = data.get("nameJP", "")
	email = data.get("email", "")
	note = data.get("note", "")
	active = data.get("active", 0)
