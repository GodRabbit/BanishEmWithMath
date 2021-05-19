extends Node


# global sound manager to prevent loss of audio while changing scenes

# nodes:
onready var ui_stream_player = $ui_stream_player

onready var button_click1 = preload("res://audio/ui/kenny/impactMetal_heavy_001.ogg")

onready var sfx_ids = {"button_click1": button_click1}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_sound(id):
	if sfx_ids.has(id):
		sfx_ids[id].loop = false
		ui_stream_player.stream = sfx_ids[id]
		ui_stream_player.play()
