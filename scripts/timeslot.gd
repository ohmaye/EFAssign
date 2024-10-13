# File: res://scripts/TimeSlot.gd
extends Assign

class_name TimeSlot  # Registers the class globally as 'TimeSlot'

# Time Slots
static var SHOW_COLUMNS = ["weekday", "start_time", "end_time", "active"]
static var KEY = "timeslot_id"

# Class Properties
var timeslot_id: String
var weekday: String
var start_time: String
var end_time: String
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    timeslot_id = data.get("timeslot_id", "")
    weekday = data.get("weekday", "")
    start_time = data.get("start_time", "")
    end_time = data.get("end_time", "")
    active = data.get("active", 0)