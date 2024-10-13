# File: res://scripts/ProgramEntry.gd
extends Assign

class_name Program  # Registers the class globally as 'ProgramEntry'

# Class Properties
var program: String
var show: int

# Custom Constructor
func _init(data: Dictionary = {}):
    program = data.get("program", "")
    show = data.get("show", 0)

