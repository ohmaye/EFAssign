# File: res://scripts/Weekday.gd
extends Object

class_name Weekday  # Registers the class globally as 'Weekday'

# Class Properties
var sort_key: int
var weekday: String

# Custom Constructor
func _init(data: Dictionary = {}):
    sort_key = data.get("sort_key", 0)
    weekday = data.get("weekday", "")