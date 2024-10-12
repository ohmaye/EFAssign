# File: res://scripts/Course.gd
extends Object

class_name Course  # Registers the class globally as 'Course'

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

# Optional: Method to display details
func display_details():
    print("Course ID:", course_id)
    print("Code:", code)
    print("Title:", title)
    print("Active:", active)