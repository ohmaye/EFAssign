# File: res://scripts/TimeSlot.gd
extends Assign

class_name TimeSlot  # Registers the class globally as 'TimeSlot'

# Time Slots
static var SHOW_COLUMNS = ["weekday", "active", "start_time", "end_time"]
static var KEY = "timeslot_id"
static var TABLE = "timeslots"

# Class Properties
var timeslot_id: String
var weekday: String
var start_time: String
var end_time: String
var active: bool

# Custom Constructor
func _init(data: Dictionary = {}):
    timeslot_id = data.get("timeslot_id")
    weekday = data.get("weekday") if data.get("weekday") else ""
    start_time = data.get("start_time") if data.get("start_time") else ""
    end_time = data.get("end_time") if data.get("end_time") else ""
    active = true if data.get("active") else false