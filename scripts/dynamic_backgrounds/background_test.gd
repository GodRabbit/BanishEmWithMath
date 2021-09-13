extends "res://scripts/dynamic_backgrounds/abstract_dynamic_background.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_spawn_enemies():
	print("debug test called <on_spawn_enemies>")
	$anim.play("move")
	yield($anim, "animation_finished")
	.on_spawn_enemies()
	print("super <on_spawn_enemies> called")
