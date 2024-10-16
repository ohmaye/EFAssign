extends GridContainer

@onready var field = %PopupField

func _ready() -> void:
	for i in 14:
		var lbl = field.duplicate()
		lbl.visible = true
		# lbl.text = "Title " + str(i)
		lbl.custom_minimum_size = Vector2(180, 50)
		add_child(lbl)
