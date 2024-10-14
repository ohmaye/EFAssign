extends Controller

@onready var _class = Class_

var popup = preload("res://UI/tree_table/popup/popup.tscn")

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
	var db_classes = AppDB.db_get(sql)
	var classes : Array[Class_] = []
	for db_class in db_classes:
		classes.append(Class_.new(db_class))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % db_classes.size()

	%TreeTable.render(_class, classes)


func _on_data_changed():
	_load_data_and_render()
