extends Controller

@onready var _class = DemandView

const sql = "SELECT * FROM filtered_demand_view ORDER BY firstName, lastName"

func _ready():
	_load_data_and_render()


func _load_data_and_render():
	var db_demand = AppDB.db_get(sql)
	var demands : Array[DemandView] = []
	for demand in db_demand:
		demands.append(DemandView.new(demand))
	
	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % demands.size()

	%TreeTable.render(_class, demands)


func _on_data_changed():
	_load_data_and_render()
