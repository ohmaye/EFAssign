extends ColorPickerButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_picker().add_preset(Color(1,0,1))
	get_picker().add_preset(Color(0,0,1))
