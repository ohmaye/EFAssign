# File: res://scripts/Student.gd
extends Assign

class_name Student  # Registers the class globally as 'Student'

# Students
static var SHOW_COLUMNS = ["firstName", "lastName", "email", "program", "level", "active", "timestamp"]
static var KEY = "student_id"

# Class Properties
var student_id: String
var email: String
var firstName: String
var lastName: String
var level: String
var program: String
var timestamp: String
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    student_id = data.get("student_id", "")
    email = data.get("email", "")
    firstName = data.get("firstName", "")
    lastName = data.get("lastName", "")
    level = data.get("level", "")
    program = data.get("program", "")
    timestamp = data.get("timestamp", "")
    active = data.get("active", 0)