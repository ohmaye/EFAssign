# File: res://scripts/Choice.gd
extends Assign

class_name Choice  # Registers the class globally as 'Choice'

# Class Properties
var choice: String
var show: int
var weekday: String

# Custom Constructor
func _init(data: Dictionary = {}):
    choice = data.get("choice", "")
    show = data.get("show", 0)
    weekday = data.get("weekday", "")

# Optional: Method to display details
func display_details():
    print("Choice:", choice)
    print("Show:", show)
    print("Weekday:", weekday)