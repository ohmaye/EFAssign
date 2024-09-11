extends PopupPanel

var label_scn = preload("res://UI/ui_elements/popup_label.tscn")
var field_scn = preload("res://UI/ui_elements/popup_field.tscn")
var container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container = $ColorRect/VBoxContainer

func render(id, row, columns) -> void:
	remove_all_children(container)
	print(id)
	for field in columns:
		var label = label_scn.instantiate()
		label.text = field.capitalize()
		container.add_child(label)

		var lineEdit = field_scn.instantiate()
		lineEdit.text = str(row[field]) if row[field] else ""
		container.add_child(lineEdit)


# Override the _notification function to handle window resize events
# func _notification(what):
# 	# Detect when the window is resized
# 	if what == NOTIFICATION_WM_SIZE_CHANGED:
# 		# Re-center the PopupPanel
# 		print("Need to recenter")

func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		child.queue_free()  # This will delete the child from memory