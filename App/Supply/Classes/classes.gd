extends Controller

const COLUMN_NAMES  = Constants.CLASSES_SHOW_COLUMNS
const KEY = Constants.CLASSES_KEY
var query_info 

var popup = preload("res://UI/popup/popup.tscn")

const sql = """
	SELECT c.code as 'course', cls.title as 'class', cls.for_program as 'for_program', r.name as 'where', ts.weekday || ' ' || ts.start_time as 'when', t.name as 'who' 
	FROM classes cls
	LEFT JOIN courses c USING (course_id)
	LEFT JOIN rooms r USING (room_id)
	LEFT JOIN timeslots ts USING (timeslot_id)
	LEFT JOIN teachers t USING (teacher_id)
"""

func _ready():
	# Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var classes = AppDB.db_get(sql)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % classes.size()

	query_info = QueryInfo.new("courses", COLUMN_NAMES, classes, KEY )
	
	$Table.render(query_info)


func _on_data_changed():
	_load_data_and_render()
