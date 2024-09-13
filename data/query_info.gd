extends Node

# When creating tables with editable rows, pass this packet along

class_name QueryInfo

var table : String                  # Table name
var columns : Array = []            # Column names
var rows : Array = []               # Record
var key : String                    # Record key

# Constructor
func _init(_table: String, _columns: Array, _rows: Array, _key: String) -> void:
	table = _table
	columns = _columns
	rows = _rows
	key = _key
