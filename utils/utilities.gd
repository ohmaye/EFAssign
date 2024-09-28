extends Node

class_name Utilities

## Remove Children
##
## Given a container, remove all children and free the resources
func remove_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		parent_node.remove_child(child)
		# This will delete the child from memory
		child.queue_free()  

## Create UUID
const uuid = preload('res://addons/uuid.gd')

## Save and Load user preferences
##
## Use the UserPrefs class to store preferences in "user://user_prefs.tres"
func save_user_prefs():
	var user_prefs : UserPrefs = UserPrefs.new()

	user_prefs.path = "user://"
	user_prefs.file = ""

	ResourceSaver.save(user_prefs, "user://user_prefs.tres")

func load_user_prefs():
	var user_prefs : UserPrefs = load("user://user_prefs.tres")

	GlobalVars.path = user_prefs.path
	GlobalVars.file = user_prefs.file


## Scene Utilities
##
## First empty the parent container, then load the next scene

func change_scene(container : Control, scene : PackedScene):
	Utils.remove_all_children(container)
	var scene_node = scene.instantiate()
	# scene_node.call_deferred("render")	
	container.add_child(scene_node)
	return scene_node
