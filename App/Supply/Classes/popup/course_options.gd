extends OptionButton

var selected_course_id = ""

const sql_courses_for_class = """
	SELECT * FROM courses WHERE active = 1
"""
func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _render(row):
	var courses = AppDB.db_get(sql_courses_for_class)

	var index = 0
	for course in courses:
		var choice = course.code.rpad(14, " ") + course.title
		add_item( choice, index)
		set_item_metadata(index, course.course_id)
		if course.course_id == row["course_id"]:
			select( get_item_count() - 1)
		index += 1

func _on_item_selected(index):
	selected_course_id = get_item_metadata(index)
	print("Selected Course ID:", selected_course_id, "Index: ", index)
