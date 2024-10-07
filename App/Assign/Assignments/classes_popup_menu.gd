extends PopupMenu

var classes : Array

const sql_classes = """
		SELECT cv.class_id, cv.class as title, cv.'when', cv.who, cv.for_program FROM classes_view cv
		WHERE timeslot_active = 1
		ORDER BY cv.class, cv.weekday_sort_key, cv.'when'
"""

func _ready():
	index_pressed.connect(_on_assignment_selected)


func load_and_render():
	classes = AppDB.db_get(sql_classes)
	print("Loaded classes: ", classes)
	clear()

	add_item("Clear Assignment")
	for cls in classes:
		var class_title = cls.get('title') if cls.get('title') else "?"
		var time = cls.get('when') if cls.get('when') else "?"
		var who = cls.get('who') if cls.get('who') else "?"
		var text = "%s - %s - %s" % [time, class_title, who]
		add_item(str(text))


func _on_assignment_selected(index):
	printt("id_pressed -> Class ID: ", index, classes[index - 1].get('title'))
