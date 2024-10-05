extends Controller

@onready var grid : GridContainer = %GridContainer


const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render()

	

func _load_data_and_render():
	var weekday_records = Utils._get_active_weekdays()
	var weekdays : Array = []

	for record in weekday_records:
		weekdays.append(record['weekday'] + " " + record['start_time'])
		
	var headers = Utils.filtered_columns(COLUMN_NAMES) + weekdays
	grid.columns = headers.size()
	print("Headers: ", headers)

	# Create Headers
	for header in headers:
		var node = Label.new()
		node.text = header
		grid.add_child(node)
	
	var db = AppDB.db
	var result = db.query(sql)
	var rows = []

	# If there are no results, return
	if not result:
		return
	else:
		rows = db.query_result
	
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % rows.size()
	# var query_info = QueryInfo.new("demand_view", Utils.filtered_columns(COLUMN_NAMES), rows, KEY )
	for row in rows:
		var node = Label.new()
		node.text = row.firstName + " " + row.lastName
		grid.add_child(node)
		for weekday in weekdays:
			node = Label.new()
			node.text = weekday
			grid.add_child(node)


func _get_active_weekdays() -> Array:
	var sql_active_weekdays = """
		SELECT t.weekday, start_time, end_time, sort_key FROM timeslots AS t
		JOIN weekdays AS w ON w.weekday = t.weekday
		WHERE t.active = 1
		ORDER BY sort_key
	"""
	var active_weekdays = AppDB.db.query(sql_active_weekdays)
	return active_weekdays
