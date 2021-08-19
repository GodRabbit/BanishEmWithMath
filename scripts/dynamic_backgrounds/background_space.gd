extends dynamic_background


# a dynamic background for the galactic cake boss fight, including 
#  inside the galactic cake.

# nodes:
onready var boss_galactic_cake = $boss_galactic_cake


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("move_planets")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_spawn_enemies():
	boss_galactic_cake.anim.play("bounce")
	yield(boss_galactic_cake.anim, "animation_finished")
	.on_spawn_enemies()

func on_death():
	boss_galactic_cake.anim.play("death")
	yield(boss_galactic_cake.anim, "animation_finished")
	.on_death()
