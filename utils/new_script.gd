extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello")


	var name = "John"
	var age = 30
	var formatted_string = "{0} {1} {0} {1}"
	print(formatted_string.format([name, age]))
	

	formatted_string = "Name: %s, Age: %d" % [name, age]
	print(formatted_string)  # Output: Name: John, Age: 30