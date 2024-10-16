# File: res://scripts/ClassesView.gd
extends Assign

class_name ClassesView  # Registers the class globally as 'ClassesView'

# Classes
static var SHOW_COLUMNS = ["course", "title", "for_program", "when", "where", "who"]
static var KEY = "class_id"
static var TABLE = "classes_view"

# Class Properties
var class_id: String
var course: String
var title: String
var for_program: String
var where: String  
var weekday_sort_key: int
var weekday: String
var when: String   
var who: String
var timeslot_id: String
var timeslot_active: int

# Custom Constructor
func _init(data: Dictionary = {}):
	class_id = data.get("class_id") if data.get("class_id") else ""
	course = data.get("course") if data.get("course") else ""
	title = data.get("title") if data.get("title") else ""
	for_program = data.get("for_program") if data.get("for_program") else ""
	where = data.get("where") if data.get("where") else ""
	weekday_sort_key = data.get("weekday_sort_key") if data.get("weekday_sort_key") else 0
	weekday = data.get("weekday") if data.get("weekday") else ""
	when = data.get("when") if data.get("when") else ""
	who = data.get("who") if data.get("who") else ""
	timeslot_id = data.get("timeslot_id") if data.get("timeslot_id") else ""
	timeslot_active = true if data.get("timeslot_active") else false
