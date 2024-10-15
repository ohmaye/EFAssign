extends Node

class_name AssignDB

var db : SQLite = null
const verbosity_level : int = SQLite.NORMAL

func setup_db() -> void:
	db = SQLite.new()
	# db.verbosity_level = verbosity_level

	var result : bool = false
	if GlobalVars.file_path != "":
		db.path = GlobalVars.file_path
		result = db.open_db()

	if !result:
		print("Opening Default DB")
		db.path = GlobalVars.default_path
		result = db.open_db()
		if !result:
			print("Could not open DB")

	DisplayServer.window_set_title((db.path).get_file())

# func _exit_tree() -> void:
# 	db.close_db()


func db_get(sql : String) -> Array:
	var result = db.query(sql)
	if not result:
		return []
	else:
		return db.query_result


func db_get_objects(class_, sql : String, ) -> Array:
	var result = db.query(sql)
	if not result:
		return []
	else:
		var objects = []
		for item in db.query_result:
			objects.append(class_.new(item))
		return objects


func db_run(sql : String) -> bool:
	var result = db.query(sql)
	# print("Run query: ", sql)
	return result

# Return an array of selected column names
func _get_choice_filters() -> Array:
	var result = []

	var filters = AppDB.db_get("SELECT choice FROM choices WHERE show = 0")
	for item in filters:
		result.append(item['choice'])

	return result


func filtered_columns(columns : Array) -> Array:
	var result : Array = []
	var filters = _get_choice_filters()

	for item in columns:
		if not item in filters:
			result.append(item)
	
	return result

## Active Timeslots propertly sorted by weekday
func get_active_timeslots() -> Array[TimeSlot]:
	var sql_active_weekdays = """
		SELECT t.timeslot_id, t.weekday, t.start_time, t.end_time,
			CASE 
				WHEN t.weekday = 'Mon' THEN 1
				WHEN t.weekday = 'Tue' THEN 2
				WHEN t.weekday = 'Wed' THEN 3
				WHEN t.weekday = 'Thu' THEN 4
				WHEN t.weekday = 'Fri' THEN 5
				WHEN t.weekday = 'Sat' THEN 6
				WHEN t.weekday = 'Sun' THEN 7
			END AS sort_key
		FROM timeslots AS t
		WHERE t.active = 1
		ORDER BY sort_key;
	"""

	var result : Array[TimeSlot]= []
	for timeslot in AppDB.db_get(sql_active_weekdays):
		var ts = TimeSlot.new(timeslot)
		result.append(ts)

	return result
