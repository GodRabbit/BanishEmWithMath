extends MarginContainer

const item_displayer_button = preload("res://scenes/gui/item_displayer_button.tscn")

# nodes:
onready var item_container = $main_container/item_container
onready var item_info_displayer = $main_container/button_container/item_info_displayer
onready var delete_button = $main_container/button_container/delete_button
onready var eat_button = $main_container/button_container/eat_button
onready var exit_button = $main_container/button_container/exit_button
onready var sell_button = $main_container/button_container/sell_button

# the control wants to exit.
signal request_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_inventory()
	update_gui()
	
	# signals:
	eat_button.connect("pressed", self, "on_eat_button_pressed")
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	sell_button.connect("pressed", self, "on_sell_button_pressed")

# setup the corerct amount of buttons in the item_container
# check first if even necessary.
func _setup_inventory():
	if item_container.get_children().size() == player_data.get_inventory().get_size():
		return
	else:
		var inv = player_data.get_inventory()
	
		for i in range(0, inv.get_size()):
			var b = item_displayer_button.instance()
			item_container.add_child(b)
			b.connect("pressed", self, "on_item_button_pressed")

# updates the inventory from player data:
func update_gui():
	var inv = player_data.get_inventory()
	
	for i in range(0, inv.get_size()):
		item_container.get_children()[i].set_item(inv.get_stack_at(i))

# return the index of the pressed item, or -1 if there's none.
func find_pressed_item():
	for i in range(0, item_container.get_children().size()):
		var b = item_container.get_children()[i]
		if b.pressed:
			return i
	return -1

func on_item_button_pressed():
	# search for the presed button:
	var index = find_pressed_item()
	
	# get the stack from the inventory:
	var stack = player_data.get_inventory().get_stack_at(index)
	
	# get the item id:
	var id = stack.get_item_id()
	
	# update the item_info:
	item_info_displayer.set_item_id(id)

func on_eat_button_pressed():
	var index = find_pressed_item()
	
	if index != -1:
		player_data.eat_item_at(index)
	update_gui()

func on_exit_button_pressed():
	emit_signal("request_exit")

func on_sell_button_pressed():
	var index = find_pressed_item()
	
	if index != -1:
		player_data.sell_item_at(index)
	update_gui()