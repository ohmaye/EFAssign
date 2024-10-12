extends Controller

const sql = "SELECT * FROM survey ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()

func _on_data_changed():
	_load_data_and_render()


func _load_data_and_render():
	var surveys = AppDB.db_get(sql)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % surveys.size()
		
	var query_info = QueryInfo.new("survey", Survey.SHOW_COLUMNS, surveys, Survey.KEY )

	%Table.render(query_info)
