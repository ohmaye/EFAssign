extends Controller

const COLUMN_NAMES  = Constants.DEMAND_SHOW_COLUMNS
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render()

	

func _load_data_and_render():
	var rows = AppDB.db_get(sql)
	
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % rows.size()
	var query_info = QueryInfo.new("demand_view", Utils.filtered_columns(COLUMN_NAMES), rows, KEY )

	$Table.render(query_info)
