extends Node

class_name Utilities

## Remove Children
##
## Given a container, remove all children and free the resources
func free_all_children(parent_node):
	# Loop through all children and remove them
	for child in parent_node.get_children():
		free_all_children(child)
		# This will delete the child from memory
		child.queue_free()  

## Remove treeitem children
##
## Given a treeitem, remove all children and free the resources
func free_all_treeitems(treeitem):
	# Loop through all children and remove them
	for child in treeitem.get_children():
		treeitem.remove_child(child)


## Create UUID
const uuid = preload('res://addons/uuid.gd')

## Save and Load user preferences
##
## Use the UserPrefs class to store preferences in "user://user_prefs.tres"
func save_user_prefs():
	var user_prefs : UserPrefs = UserPrefs.new()

	user_prefs.file_path = GlobalVars.file_path
	user_prefs.font_size = GlobalVars.font_size

	ResourceSaver.save(user_prefs, "user://user_prefs.tres")

func load_user_prefs():
	# If a preferences file doesn't exist create one
	var user_prefs : UserPrefs = load("user://user_prefs.tres")

	if user_prefs == null:
		save_user_prefs()
		user_prefs = load("user://user_prefs.tres")

	GlobalVars.file_path = user_prefs.file_path
	GlobalVars.font_size = user_prefs.font_size


## Scene Utilities
##
## First empty the parent container, then load the next scene

func change_scene(container : Control, scene : PackedScene):
	Utils.free_all_children(container)
	var scene_node = scene.instantiate()
	# scene_node.call_deferred("render")	
	container.add_child(scene_node)
	return scene_node

## Global Filter Utilities
##
## Make it easier to handle Global Filters affecting SQL queries and Colums in tables

# Return an array of  column names
func get_choices() -> Array:
	var result = []

	var choices = AppDB.db_get("SELECT choice FROM choices")
	for item in choices:
		result.append(item['choice'])

	return result



