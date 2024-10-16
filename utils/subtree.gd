extends Tree

func _ready():
	var root = create_item()
	set_columns(8)
	for i in 20:
		var child = create_item(root)
		for j in 12:
			child.set_text(j, "Title" + str(i))