extends Controller

const COLUMN_NAMES  = Constants.STUDENT_SHOW_COLUMNS
const KEY = Constants.STUDENT_KEY

const sql = "SELECT * FROM filtered_students_view ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render()

func _load_data_and_render():
	
	var timetables = AppDB.db_get(sql)
		
	var query_info = QueryInfo.new("students", COLUMN_NAMES, timetables, KEY )

	$Table.render(query_info)