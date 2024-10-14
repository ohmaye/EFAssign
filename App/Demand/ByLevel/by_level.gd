extends Controller

@onready var _class = DemandByLevelView

func _ready():
	_load_data_and_render()


func _load_data_and_render():
	var db_levels = AppDB.db_get("SELECT * FROM demand_by_level_view ORDER BY course, level")
	var levels : Array[DemandByLevelView] = []
	for level in db_levels:
		levels.append(DemandByLevelView.new(level))

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % levels.size()

	%TreeTable.render(_class, levels)


func _on_data_changed():
	_load_data_and_render() 


