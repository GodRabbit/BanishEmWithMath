extends Button

# Deprecated!
# see item_displayer_button2
var stack = item_stack.new()

const FILE_PATH = "res://images/items/%s.png"

# nodes

# Called when the node enters the scene tree for the first time.
func _ready():
	set_item(item_stack.new("none", 0))
	group = load("res://scenes/gui/button_groups/item_buttons.tres")

func set_item(_stack):
	stack = _stack
	update_gui()

func update_gui():
	var item = items_data.get_item_by_id(stack.get_item_id())
	if item.size() > 0 or !stack.is_empty():
		text = str(stack.get_amount())
		
		# check item texture exists.
		var path = FILE_PATH % item["id"]
		
		# load image without checking
		icon = load(path)
		
		# check before loading:
		# causes problems on export; can't seem to fix this...
#		var file2Check = File.new()
#		var doFileExists = file2Check.file_exists(path)
#		if doFileExists:
#			icon = load(path)
#		else:
#			icon = load(FILE_PATH % "none")
		
		disabled = false
	else:
		# empty stack is just empty...
		text = ""
		icon = null
		disabled = true
