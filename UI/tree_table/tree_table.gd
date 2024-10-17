extends Control

@onready var tree : Tree = %TreeTable
@onready var filters_container = %FiltersGridContainer
@onready var field_container = %FieldContainer

var root : TreeItem
var current_class = []
var current_entries = []
var headers = []

# Popup for editing
var popup_scene = preload("popup/popup.tscn")
var popup_node : CanvasLayer

# Styles for table data
var style_hover = preload("styles/style_cell_hover.tres")
var style_normal = preload("styles/style_cell_normal.tres")


func _ready():
	# Create the root item
	root = tree.create_item()

	tree.item_selected.connect(_on_item_selected)	# Show Popup
	# tree.gui_input.connect(_on_gui_input)	# Hover Effect
	
	# Create an instance of the popup dialog scene
	popup_node = popup_scene.instantiate()
	popup_node.visible = false
	add_child(popup_node)

	tree.column_title_clicked.connect(func (_column, _index): 
		printt("Column Title Clicked", _column, _index)
		_sort_tree(_column)	)

	resized.connect(_resize_filters)


func render(class_, entries : Array):
	# Set the current class and entries
	current_class = class_
	current_entries = entries

	# Clear the tree
	Utils.free_all_treeitems(root)

	# Set Tree format and initialize headers
	_setup_tree_format_and_headers()

	# Create a row for each entry
	for entry in entries:
		_create_row(class_, entry, root)

	# Create the filters if the class has filters
	_setup_column_filters()


func _setup_tree_format_and_headers():
	headers = AppDB.filtered_columns(current_class.SHOW_COLUMNS)
	# Set up the # of columns & headers
	tree.set_columns(headers.size())
	for header in headers:
		var column_index = headers.find(header)
		tree.set_column_title(column_index, header)
		tree.set_column_title_alignment(column_index, HORIZONTAL_ALIGNMENT_LEFT)
	return

func _setup_column_filters() -> void:
	# Clear the filters container
	Utils.free_all_children(filters_container)
	filters_container.columns = headers.size()

	for i in headers.size():
		var filter = field_container.duplicate()
		filter.visible = true
		var column_width = tree.get_column_width(i) - 3
		filter.custom_minimum_size = Vector2(column_width, 50)
		filters_container.add_child(filter)
		filter.get_node("Field").text_submitted.connect(_on_filter_text_submitted)

	call_deferred("_resize_filters")


func _on_filter_text_submitted(text):
	print("Filter Text Submitted: ", text)
	var filters = []
	for i in headers.size():
		var filter = filters_container.get_child(i)
		var filter_text = filter.get_node("Field").text
		filters.append(filter_text)
	print("Filters: ", filters)
	_apply_filters(filters)


func _apply_filters(filters : Array):
	for row in range(root.get_child_count()):
		var item = root.get_child(row)
		var show_row = true
		for col in range(headers.size()):
			var cell_text = item.get_text(col)
			if filters[col] != "" and not cell_text.to_lower().begins_with(filters[col].to_lower()):
				show_row = false
				break
		item.visible = show_row


func _resize_filters():
	for i in headers.size():
		var filter = filters_container.get_child(i)
		var column_width = tree.get_column_width(i) - 3
		filter.custom_minimum_size = Vector2(column_width, 50)

var sort_order = {}
func _sort_tree(column: int, ascending: bool = true):
	var items = []
	for i in range(root.get_child_count()):
		items.append(root.get_child(i))

	if column in sort_order:
		sort_order[column] = not sort_order[column]
	else:
		sort_order[column] = ascending

	items.sort_custom(func (a,b): return _compare_items(a,b,column,sort_order[column]))

	# Clear the root and add items back in sorted order
	for item in items:
		root.remove_child(item)
	for item in items:
		root.add_child(item)

func _compare_items(a, b, column, ascending):
	var text_a = a.get_text(column)
	var text_b = b.get_text(column)
	if ascending:
		return text_a.naturalnocasecmp_to(text_b) < 0
	else:
		return text_a.naturalnocasecmp_to(text_b) > 0


func _create_row(class_, entry, parent_node):
	var _row = parent_node.create_child()
	var _columns = (AppDB.filtered_columns(class_.SHOW_COLUMNS))
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


func _on_item_selected():
	popup_node.render(tree.get_selected().get_metadata(0), current_class)
	popup_node.visible = true


## Hover Effect
var hover_item = null
func _on_gui_input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = event.position
		var item = tree.get_item_at_position(mouse_pos)

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
	else:
		# Allow other events to propagate up the hierarchy
		pass

			
func _clear_item_row(item): 
	for i in range(0, tree.columns):
		item.clear_custom_bg_color(i)


func _set_item_row_bg_color(item, color):
	for i in range(0, tree.columns):
		item.set_custom_bg_color(i, color)
