# File: res://scripts/Assignment.gd
extends Object

class_name Assignment  # Registers the class globally as 'Assignment'

# Class Properties
var assignment_id: String
var student_id: String
var class_id: String

# Custom Constructor
func _init(data: Dictionary = {}):
    assignment_id = data.get("assignment_id", "")
    student_id = data.get("student_id", "")
    class_id = data.get("class_id", "")

# Optional: Method to display details
func display_details():
    print("Assignment ID:", assignment_id)
    print("Student ID:", student_id)
    print("Class ID:", class_id)