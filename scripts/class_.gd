# File: res://scripts/ClassEntry.gd
extends Assign

class_name Class_  # Registers the class globally as 'ClassEntry'


# Classes
static var SHOW_COLUMNS = ["course", "title", "for_program", "when", "where", "who"]
static var KEY = "class_id"
static var TABLE = "classes"
static var EDITABLE :bool = true

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
    class_id = data.get("class_id") if data.get("class_id") else ""
    title = data.get("title") if data.get("title") else ""
    course_id = data.get("course_id") if data.get("course_id") else ""
    room_id = data.get("room_id") if data.get("room_id") else ""
    timeslot_id = data.get("timeslot_id") if data.get("timeslot_id") else ""   
    teacher_id = data.get("teacher_id") if data.get("teacher_id") else ""
    for_program = data.get("for_program") if data.get("for_program") else ""
