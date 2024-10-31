# File: res://scripts/Assignment.gd
extends Assign

class_name Assignment  # Registers the class globally as 'Assignment'

# Class Properties
var assignment_id: String
var student_id: String
var class_id: String
var uploaded: bool

# Custom Constructor
func _init(data: Dictionary = {}):
	assignment_id = data.get("assignment_id", "")
	student_id = data.get("student_id", "")
	class_id = data.get("class_id", "")
	uploaded = true if data.get("uploaded") else false
