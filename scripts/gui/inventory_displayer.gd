extends Panel

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

const item_displayer_button = preload("res://scenes/gui/item_displayer_button2.tscn")

# nodes:
onready var item_container = $inventory_container/main_container/minor_container/item_container
onready var item_info_displayer = $inventory_container/main_container/item_info_displayer
onready var delete_button = $inventory_container/main_container/minor_container/button_container/delete_button
onready var eat_button = $inventory_container/main_container/minor_container/button_container/eat_button
onready var exit_button = $inventory_container/main_container/minor_container/button_container/exit_button
onready var sell_button = $inventory_container/main_container/minor_container/button_container/sell_button
onready var sell_stack_button = $inventory_container/main_container/minor_container/button_container/sell_stack_button

# the control wants to exit.
signal request_exit
signal item_sold

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_inventory()
	update_gui()
	
	# signals:
	eat_button.connect("pressed", self, "on_eat_button_pressed")
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	sell_button.connect("pressed", self, "on_sell_button_pressed")
	sell_stack_button.connect("pressed", self, "on_sell_stack_button_pressed")

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
	# if shift is pressed sell entire stack
	var is_shift = false
	if Input.is_action_pressed("ui_shift"):
		is_shift = true

	var index = find_pressed_item()
	
	if index != -1:
		if !is_shift: # sell single item
			player_data.sell_item_at(index)
		else: # sell entire stack
			player_data.sell_stack_at(index)
		emit_signal("item_sold")
	update_gui()

func on_sell_stack_button_pressed():
	var index = find_pressed_item()
	
	if index != -1:
		player_data.sell_stack_at(index)
		emit_signal("item_sold")
	update_gui()
