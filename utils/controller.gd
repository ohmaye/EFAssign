extends Control

class_name Controller

## Track changes in data
##
## When a page depends on underlying data, ensure that the pages receives a signal of changes

func render():
	pass

func _enter_tree():
	Signals.data_changed.connect(_on_data_changed)
	
func _exit_tree():
	Signals.data_changed.disconnect(_on_data_changed)

func _on_data_changed():
	print("Data changed")
	render()
