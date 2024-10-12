# File: res://scripts/Room.gd
extends Object

class_name Room  # Registers the class globally as 'Room'

# Rooms
static var SHOW_COLUMNS = ["name", "type", "capacity", "active"]
static var KEY = "room_id"

# Class Properties
var room_id: String
var name: String
var type: String
var capacity: int
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    room_id = data.get("room_id", "")
    name = data.get("name", "")
    type = data.get("type", "")
    capacity = data.get("capacity", 0)
    active = data.get("active", 0)

