# File: res://scripts/ProgramEntry.gd
extends Object

class_name Program  # Registers the class globally as 'ProgramEntry'

# Class Properties
var program: String
var show: int

# Custom Constructor
func _init(data: Dictionary = {}):
    program = data.get("program", "")
    show = data.get("show", 0)

# Optional: Method to display details
func display_details():
    print("Program:", program)
    print("Show:", show)