extends Control


# a control that hold lots of crafting buttons. Its the manager of the crafting, 
# what else it's supposed to do?

#const crafting_button = preload("res://scenes/gui/crafting_button.tscn")

onready var vmain_container = $main_panel/vmain_container
onready var recipe_panel = $recipe_panel
onready var crafting_button = $recipe_panel/recipe_container/crafting_button
onready var command_craft_button = $recipe_panel/recipe_container/craft_button

signal crafting_pressed(r)

# the ids of the ercipes that the manager will display
var arr_recipes_ids = []

var arr_local_crafting_recipes = []
var arr_buttons = []

var last_selected_recipe = null # deprecated -> switch to current_recipe
var current_recipe = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect signals:
	command_craft_button.connect("pressed", self, "on_command_craft_pressed")
	
	set_ids(["pick_apples"])

# sets the ids of the crafting recipes to be displayed
func set_ids(a : Array):
	arr_recipes_ids = a.duplicate()
	update_gui()

func update_gui():
	arr_local_crafting_recipes = []
	arr_buttons = []
	
	for c in vmain_container.get_children():
		if c is Button:
			vmain_container.remove_child(c)
			c.queue_free()
	
	var bg = ButtonGroup.new()
	for r_id in arr_recipes_ids:
		var r = array_recipes.get_recipe_by_id(r_id)
		arr_local_crafting_recipes.append(r)
		var b = Button.new()
		vmain_container.add_child(b)
		b.text = r.get_crafting_name()
		b.toggle_mode = true
		b.group = bg
		b.connect("pressed", self, "on_crafting_pressed")
		arr_buttons.append(b)

# finds the curernt recipe, through the selected button.
# returns an index in the array arr_buttons.
# returns -1 if there's no pressed button
func find_current_recipe():
	for i in range(0, arr_buttons.size()):
		var b = arr_buttons[i]
		if b.pressed:
			return i
	return -1

func on_crafting_pressed():
	# the currently pressed recipe
	var temp  = find_current_recipe()
	
	# if you double clicked this button -> its a craft order.
	# is it a really feature or a bug??
	if false: #current_recipe == temp:
		emit_signal("crafting_pressed", arr_local_crafting_recipes[current_recipe])
		recipe_panel.hide()
	else:
		current_recipe = temp
		var r = arr_local_crafting_recipes[current_recipe]
		crafting_button.set_recipe(r)
		recipe_panel.show()
		
		if !player_data.check_recipe(r): 
			command_craft_button.disabled = true
		else:
			command_craft_button.disabled = false

func on_command_craft_pressed():
	emit_signal("crafting_pressed", arr_local_crafting_recipes[current_recipe])
	recipe_panel.hide()

func get_last_selected_recipe():
	return last_selected_recipe

func hide():
	recipe_panel.hide()
	.hide()
