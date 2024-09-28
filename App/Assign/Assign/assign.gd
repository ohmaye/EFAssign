extends Controller

# Test
var demand_by_course = preload("res://App/assign/Assign/demand_by_course.tscn")
var connect_scene = preload("res://App/assign/Assign/connect.tscn")
var supply_by_weekday = preload("res://App/assign/Assign/supply_by_weekday.tscn")

func _ready():
	var scene = demand_by_course.instantiate()
	%DemandTable.add_child(scene)
	scene = connect_scene.instantiate()
	scene.call_deferred("render")
	%AssignTable.add_child(scene)
	var scene2 = supply_by_weekday.instantiate()
	# scene2.call_deferred("render")
	%SupplyTable.add_child(scene2)

	