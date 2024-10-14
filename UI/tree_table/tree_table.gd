extends Tree

var root : TreeItem
var current_class
var current_entries

# Popup for editing
var popup_scene = preload("popup/popup.tscn")
var popup_node : CanvasLayer

# Styles for table data
var style_hover = preload("styles/style_cell_hover.tres")
var style_normal = preload("styles/style_cell_normal.tres")


func _ready():
	# Doesn't inherit from Controller so need to connect signal
	Signals.data_changed.connect(_on_data_changed)
	item_selected.connect(_on_item_selected)
	
	# Create an instance of the popup dialog scene
	popup_node = popup_scene.instantiate()
	popup_node.visible = false
	add_child(popup_node)

	# Create the root item
	root = create_item()


func render(class_, entries : Array):
	# Set the current class and entries
	current_class = class_
	current_entries = entries

	# Clear the tree
	Utils.free_all_treeitems(root)

	# Set Tree format and initialize headers
	_set_format_and_headers(class_.SHOW_COLUMNS)

	# Create a row for each entry
	for entry in entries:
		_create_row(class_, entry, root)


func _set_format_and_headers(headers):
	# Set up the # of columns & headers
	set_columns(headers.size())
	for header in headers:
		var column_index = headers.find(header)
		set_column_title(column_index, header.capitalize())
		set_column_title_alignment(column_index, HORIZONTAL_ALIGNMENT_LEFT)
	return


func _create_row(class_, entry, parent_node):
	var _row = parent_node.create_child()
	var _columns = class_.SHOW_COLUMNS
	_row.set_metadata(0, entry)

	for column in _columns:
		var index = _columns.find(column)
		_create_field(index, entry[column], _row)


func _create_field(index, field, row):
	match typeof(field):
		TYPE_STRING:
			row.set_text(index, str(field) if field else "-") 
			row.set_text_alignment(index, HORIZONTAL_ALIGNMENT_LEFT)
		TYPE_INT:
			row.set_text(index, str(field) if field else "0") 
			row.set_text_alignment(index, HORIZONTAL_ALIGNMENT_LEFT)
		TYPE_BOOL:
			row.set_cell_mode(index, TreeItem.CELL_MODE_CHECK)
			row.set_checked(index, field)
		_:
			print("Unknown type")

func _on_data_changed():
	render(current_class, current_entries)


func _on_item_selected():
	popup_node.render(get_selected().get_metadata(0), current_class)
	popup_node.visible = true


var hover_item = null
func _gui_input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = event.position
		var item = get_item_at_position(mouse_pos)

		if not item:
			if hover_item:
				_clear_item_row(hover_item)
				hover_item = null
			return

		if not hover_item:
			hover_item = item
		
		if hover_item != item:
			_clear_item_row(hover_item)
			_set_item_row_bg_color(item, Color(0.5, 0.5, 0.5, 0.5))
			hover_item = item

			
func _clear_item_row(item): 
	for i in range(0, columns):
		item.clear_custom_bg_color(i)

func _set_item_row_bg_color(item, color):
	for i in range(0, columns):
		item.set_custom_bg_color(i, color)