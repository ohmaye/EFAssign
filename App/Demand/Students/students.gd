extends Controller

@onready var _class = Student

var popup = preload("res://UI/tree_table/popup/popup.tscn")

const sql = "SELECT * FROM filtered_students_view ORDER BY firstName, lastName"

func _ready():   
	Signals.add_new.connect(_add_new)
	_load_data_and_render()


func _load_data_and_render():
	var db_students = AppDB.db_get(sql)
	var students : Array[Student] = []
	for student in db_students:
		students.append(Student.new(student))
	
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % students.size()

	%TreeTable.render(_class, students)


func _on_data_changed():
	_load_data_and_render()


func _add_new():
	var popup_node = popup.instantiate()
	popup_node.visible = true
	add_child(popup_node)
	
	var id = Utils.uuid.v4()
	var sql_stmt = "INSERT INTO students (student_id)  VALUES ('%s')" % id

	var student = Student.new({"student_id": id})

	var result = AppDB.db_run(sql_stmt.format([id]))

	if result:
		popup_node.render(student, _class)
		popup_node.visible = true	
		Signals.data_changed.emit()