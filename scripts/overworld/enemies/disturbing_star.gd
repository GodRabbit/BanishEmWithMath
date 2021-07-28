extends "res://scripts/overworld/object_area.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("spawn")


func on_spawn():
	pass
