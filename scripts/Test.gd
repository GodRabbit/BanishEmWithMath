extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var x = 7
	var arr = math_util.split(x)
	print(arr)
#	var p = puzzle_addition.new()
#	print(p)
#	$battle_window.set_enemy(enemies_data.get_enemy_by_id("angry_apple"))
	
#	for i in range(2, 300):
#		if math_util.is_prime(i):
#			print(i)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
