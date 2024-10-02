extends ColorRect

@onready var container = %HomeContent

var overview_scene = preload("res://App/Home/Overview/overview.tscn")
var open_cycle_scene = preload("res://App/Home/OpenCycle/open_cycle.tscn")
var save_cycle_as_scene = preload("res://App/Home/SaveCycleAs/save_cycle_as.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_overview_btn_pressed() -> void:
	Utils.change_scene(container, overview_scene)


func _on_open_cycle_btn_pressed() -> void:
	Utils.change_scene(container, open_cycle_scene)


func _on_save_cycle_as_btn_pressed() -> void:
	Utils.change_scene(container, save_cycle_as_scene)


func _on_quit_btn_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_new_cycle_btn_pressed() -> void:
	pass # Replace with function body.
