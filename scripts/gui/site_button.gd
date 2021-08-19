extends MarginContainer


# a gui scene. A button for the player to purchase a site AND go to it once it 
# bought.

export var site_id = "farm"

# nodes:
onready var purchase_button = $main_container/purchase_container/purchase_button
onready var main_button = $main_container/main_button
onready var purchase_label = $main_container/purchase_container/purchase_label
onready var purchase_container = $main_container/purchase_container
onready var addition_purchase_container = $main_container/additional_purchase_container

# Called when the node enters the scene tree for the first time.
func _ready():
	purchase_button.connect("pressed", self, "on_purchase_button_pressed")
	main_button.connect("pressed", self, "on_main_button_pressed")
	update_gui()

func set_site_id(id):
	site_id = id
	update_gui()

func update_gui():
	# TODO: add the texture for each of the sites, and a textureRect
	# that turn gray when the site is unlocked
	main_button.text = enemies_data.get_site_name(site_id)
	
	if is_unlocked():
		# if the site is unlocked the purchase button is useless
		purchase_container.hide()
		addition_purchase_container.hide()
		main_button.disabled = false
	else:
		# not unlocked yet, so you can't use the main button to go to the site
		main_button.disabled = true
		
		
		var site_price = enemies_data.get_site_price(player_data.get_current_zone(), site_id)
		# sets the purchase money button text:
		purchase_label.text = "%d" % site_price["money"]
		
		# set the item purchase text
		var site_keys = site_price.keys()
		
		for c in addition_purchase_container.get_children():
			addition_purchase_container.remove_child(c)
			c.queue_free()
		
		# loop through the item ids in <site_keys> and asdd them:
		for k in site_keys: 
			# k is item_id or money
			if k != "money":
				var item_displayer = load("res://scenes/gui/item_displayer_vertical.tscn").instance()
				addition_purchase_container.add_child(item_displayer)
				item_displayer.set_item(item_stack.new(k, site_price[k]))
				

# checks if this site was unlocked by the player
func is_unlocked():
	return player_data.check_site(site_id)

func on_purchase_button_pressed():
	player_data.purchase_site(site_id)
	update_gui()

func on_main_button_pressed():
	transition.fade_to_combat(site_id)
