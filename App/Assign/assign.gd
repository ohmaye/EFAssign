extends ColorRect

@onready  var container = %AssignContent

var assign_scene = preload("res://App/Assign/Assign/assign.tscn")
var assignments_scene = preload("res://App/Assign/Assignments/assignments.tscn")
# var timetables_scene = preload("res://App/Assign/Timetables/timetables.tscn")


func _ready() -> void:
	Signals.total_changed.connect(_on_total_changed)

## ASSIGN TAB
##
## Handlers for Assign, Assignments, Timetables, and Teacher Preferences

func _on_assign_btn_pressed() -> void:
	# Utils.change_scene(container, assign_scene)
	%Assignments.visible = false
	%Assign.visible = true


func _on_assignments_btn_pressed() -> void:
	# Utils.change_scene(container, assignments_scene)
	%Assign.visible = false
	%Assignments.visible = true


func _on_timetables_btn_pressed() -> void:
	# Utils.change_scene(container, timetables_scene)
	pass

func _on_total_changed(total) -> void:
	%TotalLbl.text = "( Total: " + str(total) + " )"