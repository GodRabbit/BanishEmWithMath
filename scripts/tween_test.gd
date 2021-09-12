extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = $Tween
	tween.interpolate_property($Sprite, "scale", Vector2(1.0, 1.0), Vector2(0, 0), 1, 
	Tween.TRANS_LINEAR)
	tween.set_active(true)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
