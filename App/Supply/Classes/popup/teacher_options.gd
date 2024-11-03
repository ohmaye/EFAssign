extends OptionButton

var selected_teacher_id = ""

const sql_teachers_for_class = """
	WITH tp AS (
		SELECT teacher_id, course_id, rating 
		FROM teacherpreferences
		WHERE course_id = '%s'
	) 
	SELECT  t.teacher_id, t.name, t.active, tp.rating FROM  teachers t
	LEFT JOIN tp ON tp.teacher_id = t.teacher_id
	WHERE t.active = 1
	ORDER BY tp.rating DESC, t.name COLLATE NOCASE
"""
func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _render(row):
	var sql_stmt = sql_teachers_for_class % row["course_id"]
	var empty_teacher = {"teacher_id": "", "name": "", "active": 1, "rating": 0}
	var teachers = [empty_teacher] + AppDB.db_get(sql_stmt)

	var index = 0
	for teacher in teachers:
		var rating = str(teacher.rating) if teacher.rating else "?"
		add_item( rating + " " + teacher.name, index)
		set_item_metadata(index, teacher.teacher_id)
		if teacher.teacher_id == row["teacher_id"]:
			select( get_item_count() - 1)
			selected_teacher_id = teacher.teacher_id
		index += 1

func _on_item_selected(index):
	selected_teacher_id = get_item_metadata(index)
