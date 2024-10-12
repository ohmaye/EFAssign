# File: res://scripts/ClassEntry.gd
extends Object

class_name Class_  # Registers the class globally as 'ClassEntry'


# Classes
static var SHOW_COLUMNS = ["course", "class", "for_program", "when", "where", "who"]
static var KEY = "class_id"

# Class Properties
var class_id: String
var title: String
var course_id: String
var room_id: String
var timeslot_id: String
var teacher_id: String
var for_program: String

# Custom Constructor
func _init(data: Dictionary = {}):
    class_id = data.get("class_id", "")
    title = data.get("title", "")
    course_id = data.get("course_id", "")
    room_id = data.get("room_id", "")
    timeslot_id = data.get("timeslot_id", "")
    teacher_id = data.get("teacher_id", "")
    for_program = data.get("for_program", "")
