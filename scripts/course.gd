# File: res://scripts/Course.gd
extends Assign

class_name Course  # Registers the class globally as 'Course'

# Courses
static var SHOW_COLUMNS = ["code", "active", "title"]
static var KEY = "course_id"
static var TABLE = "courses"
static var EDITABLE  : bool = true

# Class Properties
var course_id: String
var code: String
var title: String
var active: bool

# Custom Constructor
func _init(data: Dictionary = {}):
    course_id = data.get("course_id") if data.get("course_id") else ""
    code = data.get("code") if data.get("code") else ""
    title = data.get("title") if data.get("title") else "" 
    active = true if data.get("active") else false

