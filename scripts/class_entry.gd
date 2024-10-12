# File: res://scripts/ClassEntry.gd
extends Object

class_name ClassEntry  # Registers the class globally as 'ClassEntry'

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
    class_id = data.get("class_id", "")
    title = data.get("title", "")
    course_id = data.get("course_id", "")
    room_id = data.get("room_id", "")
    timeslot_id = data.get("timeslot_id", "")
    teacher_id = data.get("teacher_id", "")
    for_program = data.get("for_program", "")

# Optional: Method to display details
func display_details():
    print("Class ID:", class_id)
    print("Title:", title)
    print("Course ID:", course_id)
    print("Room ID:", room_id)
    print("Timeslot ID:", timeslot_id)
    print("Teacher ID:", teacher_id)
    print("For Program:", for_program)