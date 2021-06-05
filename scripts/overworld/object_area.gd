extends Area2D

class_name object_area

# similar to crafting area, just for distructable objects.
# when the player clicks on the area, the object will emit a signal and then
# be destroyed.
# (will be handled by the world to call crafting window)

export var enemy_id = "none"

# a signal to be emitted when the player presses the object
# r is a recipe_id associated with this object.
signal object_pressed(r)

# a boolean; is the object fired or not yet? Fired objects are objects the 
# player pressed on them and are waiting deletion
var fired = false

# whether the enemy is paused
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("object_areas")

# no signal. just checks for mouse clicks.
# NOTE: all mouse clicks will trigger this. not just the left!
# fix this sometime. maybe.
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		# check if the player can intercat with enemies or on cooldown:
		# this mechanic is to prevent 2 enemies be pressed at the same time
		if player_data.can_interact_with_enemies() and !paused:
			# the player is now on cooldown:
			player_data.start_pressing_cooldown()
			
			# emit signals:
			emit_signal("object_pressed",enemy_id)
			
			# mark the object for deletion
			fired = true

func is_fired():
	return fired

func set_pause(val):
	paused = val
