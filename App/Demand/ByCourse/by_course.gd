extends Controller

@onready var _class = DemandByCourseView


func _ready():
	_load_data_and_render()


func _load_data_and_render():
	var db_courses = AppDB.db_get("SELECT * FROM demand_by_course_view")
	var courses : Array[DemandByCourseView] = []
	for course in db_courses:
		courses.append(DemandByCourseView.new(course))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % courses.size()

	%TreeTable.render(_class, courses)


func _on_data_changed():
	_load_data_and_render()
