extends Node

class_name Utils

func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		# This will delete the child from memory
		child.queue_free()  