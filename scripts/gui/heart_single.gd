extends TextureRect


# a scene for a single hp heart

# nodes:
onready var heart_particles = $heart_particles

const TEXTURE_FULL = preload("res://images/gui/heart_full.png")
const TEXTURE_EMPTY = preload("res://images/gui/heart_empty.png")

# whether this heart is filled or not.
export var filled = true


# Called when the node enters the scene tree for the first time.
func _ready():
	update_gui()

# true = filled
# false = empty
func set_state(_filled : bool):
	filled = _filled
	update_gui()

func is_filled():
	return filled

func update_gui():
	if filled:
		texture = TEXTURE_FULL
		heart_particles.emitting = true
	else:
		heart_particles.emitting = false
		texture = TEXTURE_EMPTY
