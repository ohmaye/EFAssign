extends Controller

const COLUMN_NAMES  = Constants.SURVEY_COLUMN_NAMES
const KEY = Constants.SURVEY_KEY

const sql = "SELECT * FROM survey ORDER BY firstName, lastName"

func _ready():
	Signals.data_changed.connect(_on_data_changed)
	_load_data_and_render()

func _on_data_changed():
	_load_data_and_render()


func _load_data_and_render():
	var db = AppDB.db
	var result = db.query(sql)

	# If there are no results, return
	if not result:
		return

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % db.query_result.size()
		
	var query_info = QueryInfo.new("survey", COLUMN_NAMES, db.query_result, KEY )

	$Table.render(query_info)
