# File: res://scripts/Room.gd
extends Assign

class_name Room  # Registers the class globally as 'Room'

# Rooms
static var SHOW_COLUMNS = ["name", "active", "type", "capacity"]
static var KEY = "room_id"
static var TABLE = "rooms"

# Class Properties
var room_id: String
var name: String
var type: String
var capacity: int
var active: bool

# Custom Constructor
func _init(data: Dictionary = {}):
	room_id = data.get("room_id") if data.get("room_id") else ""
	name = data.get("name") if data.get("name") else ""
	type = data.get("type") if data.get("type") else ""
	capacity = data.get("capacity") if data.get("capacity") else 0
	active = true if data.get("active") else false
