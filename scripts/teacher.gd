# File: res://scripts/Teacher.gd
extends Object

class_name Teacher  # Registers the class globally as 'Teacher'

# Class Properties
var teacher_id: String
var name: String
var nameJP: String
var email: String
var note: String
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    teacher_id = data.get("teacher_id", "")
    name = data.get("name", "")
    nameJP = data.get("nameJP", "")
    email = data.get("email", "")
    note = data.get("note", "")
    active = data.get("active", 0)