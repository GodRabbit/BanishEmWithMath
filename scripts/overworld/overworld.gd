extends Node2D


# An overworld scene that connects to combat, market and more.

var current_zone = "zone1"

# nodes:
onready var give_up_button = $give_up_button
onready var site_container = $site_scroll_container/site_container

# Called when the node enters the scene tree for the first time.
func _ready():
	give_up_button.connect("pressed", self, "on_give_up_button_pressed")
	
	update_gui()

func on_give_up_button_pressed():
	transition.fade_to_main_menu()

func _input(event):
	if event.is_action_released("ui_give_money"):
		player_data.add_money(1300)
		player_data.add_stars(1000)

func _empty_site_container():
	for c in site_container.get_children():
		site_container.remove_child(c)
		c.queue_free()

func update_gui():
	 # update site container:
	_empty_site_container()
	var sites = enemies_data.zones[current_zone]["sites"].keys()
	
	for s in sites:
		var b = load("res://scenes/gui/site_button.tscn").instance()
		site_container.add_child(b)
		b.set_site_id(s)
		b.update_gui()
	
	# TODO: add the same bor boss fights
	
