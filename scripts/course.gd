# File: res://scripts/Course.gd
extends Object

class_name Course  # Registers the class globally as 'Course'

# Courses
static var SHOW_COLUMNS = ["code", "title", "active"]
static var KEY = "course_id"

# Class Properties
var course_id: String
var code: String
var title: String
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    course_id = data.get("course_id", "")
    code = data.get("code", "")
    title = data.get("title", "")
    active = data.get("active", 0)

