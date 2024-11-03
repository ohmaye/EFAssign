extends OptionButton

var selected_program = ""

const programs = ["?", "All", "Intensive", "General"]

func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _render(row):

	var index = 0
	for program in programs:
		add_item( program, index)
		set_item_metadata(index, program)
		if program == row["for_program"]:
			select( get_item_count() - 1)
			selected_program = program
		index += 1

func _on_item_selected(index):
	selected_program = get_item_metadata(index)
