# File: res://scripts/StudentChoice.gd
extends Object

class_name StudentChoice  # Registers the class globally as 'StudentChoice'

# Class Properties
var choice_id: String
var student_id: String
var choice: String
var ranking: int
var course_code: String
var assigned: int

# Custom Constructor
func _init(data: Dictionary = {}):
    choice_id = data.get("choice_id", "")
    student_id = data.get("student_id", "")
    choice = data.get("choice", "")
    ranking = data.get("ranking", 0)
    course_code = data.get("course_code", "")
    assigned = data.get("assigned", 0)