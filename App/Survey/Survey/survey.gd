extends Controller

const COLUMN_NAMES  = Constants.SURVEY_SHOW_COLUMNS
const KEY = Constants.SURVEY_KEY

const sql = "SELECT * FROM survey ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()

func _on_data_changed():
	_load_data_and_render()


func _load_data_and_render():
	var surveys = AppDB.db_get(sql)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % surveys.size()
		
	var query_info = QueryInfo.new("survey", COLUMN_NAMES, surveys, KEY )

	%Table.render(query_info)
