extends VBoxContainer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a control that shows the crafting recipe. pressing the button will activate
# the crafting window for the recipe

var recipe : crafting_recipe

const item_displayer_vertical = preload("res://scenes/gui/item_displayer_vertical.tscn")

onready var recipe_button = $main_container/recipe_button

# shows the recipe:
# ingredients -> results
onready var main_label = $main_container/container/main_label # DEPRECATED
onready var ingredients_container = $main_container/ingredients_container
onready var results_container = $main_container/results_container
onready var cost_label = $main_container/cost_label

signal crafting_pressed(r)

# Called when the node enters the scene tree for the first time.
func _ready():
	recipe_button.connect("pressed", self, "on_recipe_button_pressed")
#	$main_container/recipe_button.text = "hello"

func get_recipe():
	return recipe

func set_recipe(r):
	recipe = r
	update_gui()

func update_gui():
	recipe_button.text = recipe.get_crafting_name()
	cost_label.text = str(recipe.get_energy()) + " Energy"
	
	for c in ingredients_container.get_children():
		ingredients_container.remove_child(c)
		c.queue_free()
	for c in results_container.get_children():
		results_container.remove_child(c)
		c.queue_free()
	
	for k in recipe.get_ingredients():
		var s = item_stack.new(k, recipe.get_ingredients()[k])
		var idv = item_displayer_vertical.instance()
		ingredients_container.add_child(idv)
		idv.set_item(s)
	for k in recipe.get_results():
		var s = item_stack.new(k, recipe.get_results()[k])
		var idv = item_displayer_vertical.instance()
		results_container.add_child(idv)
		idv.set_item(s)

func on_recipe_button_pressed():
	emit_signal("crafting_pressed", recipe)
