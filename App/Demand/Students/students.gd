extends Controller

const COLUMN_NAMES  = Constants.STUDENT_COLUMN_NAMES
const KEY = Constants.STUDENT_KEY

const sql = "SELECT * FROM demand WHERE program IN ('%s', '%s') ORDER BY firstName, lastName"

func _ready():   
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = false
	GlobalVars.general_checkbox.disabled = false

	Signals.data_changed.connect(_on_data_changed)
	_load_data_and_render()

func _on_data_changed():
	_load_data_and_render()

func _load_data_and_render():
	var intensive = "Intensive" if GlobalVars.intensive_checkbox.button_pressed else ""
	var general = "General" if GlobalVars.general_checkbox.button_pressed else ""
	var sql_stmt = sql % [intensive, general]

	var db = AppDB.db
	var result = db.query(sql_stmt)

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )
	
	$Table.render(query_info)