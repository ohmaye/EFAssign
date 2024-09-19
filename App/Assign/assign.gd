extends Supply

const COLUMN_NAMES  = Constants.DEMAND_COLUMN_NAMES
const KEY = Constants.DEMAND_KEY

const sql = "SELECT * FROM demand WHERE program IN ('%s', '%s') ORDER BY firstName, lastName"

# Test
var demand_by_course = preload("res://App/assign/demand_by_course.tscn")
var connect_scene = preload("res://App/assign/connect.tscn")
var classes_scene = preload("res://App/assign/supply_by_weekday.tscn")

func render():
	# Enable Intensive/General
	GlobalVars.intensive_checkbox.disabled = false
	GlobalVars.general_checkbox.disabled = false

	var intensive = "Intensive" if GlobalVars.intensive_checkbox.button_pressed else ""
	var general = "General" if GlobalVars.general_checkbox.button_pressed else ""
	var sql_stmt = sql % [intensive, general]
	
	var db = AssignDB.db
	var result = db.query(sql_stmt)

	# If there are no results, return
	if not result:
		return
		
	var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

	var scene = demand_by_course.instantiate()
	%DemandTable.add_child(scene)
	scene = connect_scene.instantiate()
	scene.call_deferred("render")
	%AssignTable.add_child(scene)
	var scene2 = classes_scene.instantiate()
	scene2.call_deferred("render")
	%SupplyTable.add_child(scene2)

	
