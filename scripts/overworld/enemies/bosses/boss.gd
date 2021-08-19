extends Node2D

# DERPRECATED!
# Author note: why not to push this into the dynamic background? is there a 
#  an advantage to keep this seperate??
# An abstract class that represnts the boss animated in the boss_combat scene.

# a signal that the boss must emit, that its ready to spawn
# enemies (usually after on_spawn_enemies is over)
signal ready_to_spawn

# a signal that emits when all the death animations are over
# this tells the boss_combat that you can move to the next scene.
signal ready_to_die

# a signal the boss emits when the spawning animation is over and the waves can begin.
signal ready_to_begin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# the boss is idle. nithing unique happens
func idle():
	pass

# the boss doing an animation before spawning enemies
func on_spawn_enemies():
	pass

func on_death():
	pass

func on_enter():
	pass
