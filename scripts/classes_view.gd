# File: res://scripts/ClassesView.gd
extends Assign

class_name ClassesView  # Registers the class globally as 'ClassesView'

# Class Properties
var class_id: String
var course: String
var title: String
var for_program: String
var where_: String  
var weekday_sort_key: int
var weekday: String
var when: String   
var who: String
var timeslot_id: String
var timeslot_active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    class_id = data.get("class_id", "")
    course = data.get("course", "")
    title = data.get("title", "")
    for_program = data.get("for_program", "")
    where_ = data.get("where", "")
    weekday_sort_key = data.get("weekday_sort_key", 0)
    weekday = data.get("weekday", "")
    when = data.get("when", "")
    who = data.get("who", "")
    timeslot_id = data.get("timeslot_id", "")
    timeslot_active = data.get("timeslot_active", 0)