extends HBoxContainer


# a scene for the player's hp bar
# Add hearts as the player's max hp
# 

const HEART_SINGLE = preload("res://scenes/gui/heart_single.tscn")

var hearts_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	player_data.connect("hp_changed", self, "update_gui")
	update_max_hp()

# updates the amount of hearts
func update_max_hp():
	# remove the current hearts
	hearts_array = []
	for c in get_children():
		remove_child(c)
		c.queue_free()
	
	# add new hearts:
	for i in range(0, player_data.get_max_hp()):
		var h = HEART_SINGLE.instance()
		hearts_array.append(h)
		add_child(h)
	
	update_gui()

# updates the health
func update_gui():
	for i in range(0, player_data.get_max_hp()):
		if i < player_data.get_current_hp():
			hearts_array[i].set_state(true) # fill the heart
		else:
			hearts_array[i].set_state(false) # fill the heart
	
	# if the player has only 1 hp, set the 1st heart in the array as last heart
	if player_data.get_current_hp() == 1:
		hearts_array[0].set_last_heart(true)
	else:
		hearts_array[0].set_last_heart(false)


