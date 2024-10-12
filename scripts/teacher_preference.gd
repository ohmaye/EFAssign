# File: res://scripts/TeacherPreference.gd
extends Object

class_name TeacherPreference  # Registers the class globally as 'TeacherPreference'

# Class Properties
var teacher_id: String
var course_id: String
var rating: int

# Custom Constructor
func _init(data: Dictionary = {}):
    teacher_id = data.get("teacher_id", "")
    course_id = data.get("course_id", "")
    rating = data.get("rating", 0)