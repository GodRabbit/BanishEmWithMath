extends MarginContainer


# a gui scene. A button for the player to purchase a site AND go to it once it 
# bought.

export var site_id = "farm"

# nodes:
onready var purchase_button = $main_container/purchase_button
onready var main_button = $main_container/main_button

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
		purchase_button.hide()
		main_button.disabled = false
	else:
		# not unlocked yet, so you can't use the main button to go to the site
		main_button.disabled = true
		
		# sets the purchase button text:
		purchase_button.text = "Purchase: %d$" % enemies_data.get_site_price(site_id)

# checks if this site was unlocked by the player
func is_unlocked():
	return player_data.check_site(site_id)

func on_purchase_button_pressed():
	player_data.purchase_site(site_id)
	update_gui()

func on_main_button_pressed():
	transition.fade_to_combat(site_id)
