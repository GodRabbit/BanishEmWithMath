extends Button


# A button used for this game. 

class_name UtilButton

export var sound_id = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "on_pressed")


func on_pressed():
	sound_manager.play_sound(sound_id)
