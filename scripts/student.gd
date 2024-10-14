# File: res://scripts/Student.gd
extends Assign

class_name Student  # Registers the class globally as 'Student'

# Students
static var SHOW_COLUMNS = ["firstName", "lastName", "email", "program", "level", "active", "timestamp"]
static var KEY = "student_id"
static var TABLE = "students"

# Class Properties
var student_id: String
var email: String
var firstName: String
var lastName: String
var level: String
var program: String
var timestamp: String
var active: bool

# Custom Constructor
func _init(data: Dictionary = {}):
    student_id = data.get("student_id")
    email = data.get("email") if data.get("email") else ""
    firstName = data.get("firstName") if data.get("firstName") else ""
    lastName = data.get("lastName") if data.get("lastName") else ""
    level = data.get("level") if data.get("level") else ""
    program = data.get("program") if data.get("program") else ""
    timestamp = data.get("timestamp") if data.get("timestamp") else ""
    active = true if data.get("active") else false