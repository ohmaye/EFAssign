extends Tree

func _ready():
	var root = create_item()
	set_columns(3)
	set_column_title(0, "Title 1")
	set_column_title(1, "Title 2")
	set_column_title(2, "Title 3")
	
	var child1 = create_item(root)
	var child2 = create_item(root)
	child1.set_text(0, "Hello")
	child2.set_text(0, "There")
	print("Created")
