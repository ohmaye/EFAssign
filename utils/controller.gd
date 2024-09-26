extends Control

class_name Controller

# ToDo: Create one for Assign and another for Demand

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func render():
	pass

func _enter_tree():
	Signals.data_changed.connect(_on_data_changed)
	
func _exit_tree():
	Signals.data_changed.disconnect(_on_data_changed)

func _on_data_changed():
	print("Data changed")
	render()
