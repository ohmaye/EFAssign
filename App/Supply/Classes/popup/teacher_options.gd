extends OptionButton

const sql_teachers_for_course = """
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

func _render(row):
	var sql_stmt = sql_teachers_for_course % row["course_id"]
	var teachers = AppDB.db_get(sql_stmt)

	for teacher in teachers:
		var rating = str(teacher.rating) if teacher.rating else "?"
		add_item( rating + " " + teacher.name)
