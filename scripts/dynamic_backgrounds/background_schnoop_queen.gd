extends dynamic_background


# nodes:
onready var boss_schnoop_queen = $boss_schnoop_queen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_spawn_enemies():
	boss_schnoop_queen.start_spawn_anim()
	yield(boss_schnoop_queen,"spawn_anim_finished")
	.on_spawn_enemies()

func on_death():
	boss_schnoop_queen.anim_body.play("death")
	yield(boss_schnoop_queen.anim_body, "animation_finished")
	.on_death()

func on_boss_health_changed(hp):
	print("schnoop queen changed hp")
