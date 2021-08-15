extends Node2D


# a unique scenes for the boss combat.
# each boss combat consists of waves to lower the Boss's HP
# when the HP reach 0, the actual Boss appear on the screen and the player must 
# answer the bosse's question - if the player succsseed  - the boss is defeated
# if not - another question will appear.

const ENEMY_POSITIONS = [Vector2(600, 88), Vector2(216, 224), Vector2(760, 400), Vector2(456, 448),
Vector2(432, 168), Vector2(840, 168), Vector2(952, 432), Vector2(608, 440), Vector2(328, 472),
Vector2(80, 104), Vector2(96, 360), Vector2(550, 264), Vector2(712, 240),
Vector2(328, 304)]
const CENTER_POS = Vector2(540.001, 261)

const ENEMY_PATH = "res://scenes/overworld/enemies/%s.tscn"

# nodes:
onready var hud = $hud
onready var objects_node = $objects
onready var boss_hp_bar = $hud/boss_hp_container/boss_hp_bar
onready var boss_name_label = $hud/boss_hp_container/boss_name_label

var boss_id = "galactic_cake"
var boss_max_hp = 50
var boss_current_hp = boss_max_hp
var boss_dic = {}
var waves_over = false


func _ready():
	hud.connect("battle_over", self, "on_battle_over")
	hud.connect("request_pause", self, "on_pause_requested")
	hud.show_window(hud.WINDOWS_IDS.NONE)
	
	player_data.connect("stars_changed", self, "on_player_stars_changed")
	
	setup_combat("galactic_cake")
	spawn_wave()

func update_gui():
	boss_hp_bar.value = (float(boss_current_hp)/float(boss_max_hp))*100.0

# call this function when combat starts
#  to setup all the varaiables needed
func setup_combat(boss_id):
	waves_over = false
	boss_dic = enemies_data.get_boss_by_id(boss_id)
	boss_max_hp = boss_dic["hp"]
	set_boss_hp(boss_max_hp)
	boss_name_label.text = boss_dic["name"]

# destroy an object from node_objects
func _destroy_object(o):
	objects_node.remove_child(o)
	o.queue_free()

# destroy objects that are object_areas, that are listed for destruction
func _remove_fired_objects():
	for o in objects_node.get_children():
		if o.is_in_group("object_areas"):
			if o.is_fired():
				_destroy_object(o)

func on_battle_over(c, t):
	if c:
		# remove dead enemies:
		_remove_fired_objects()
	if !c:
		# if the question is incorrect set all the objects as unfired
		for o in objects_node.get_children():
			if o.is_in_group("object_areas"):
				o.fired = false
	
	# when the current enemies end if the boss is still alive, create more enemies:
	# no more enemies? call another wave
	if objects_node.get_children().size() == 0 && !player_data.is_dead():
		spawn_wave()

func on_pause_requested(v):
	pause_world(v)

# go through every object that should pause while a window is open
# and (un)pause
func pause_world(val : bool):
	# pause all the enemies so they won't be able to be clicked
	for o in objects_node.get_children():
		if o.is_in_group("object_areas"):
			o.set_pause(val)

func set_boss_hp(val):
	if val >= boss_max_hp:
		boss_current_hp = boss_max_hp
	elif val <= 0:
		boss_current_hp = 0
		on_waves_over()
	else:
		boss_current_hp = val
	update_gui()

func get_boss_hp():
	return boss_current_hp

func add_boss_hp(val):
	set_boss_hp(get_boss_hp() + val)

# remove a boss hp when the player gains stars
func on_player_stars_changed(v):
	add_boss_hp(-v)

# called when hp = 0 and no more enemies
func on_waves_over():
	waves_over = true
	
#	# spawn final boss
#	var e_id = boss_dic["final_enemy"]
#	var enemy_scene = load(ENEMY_PATH % e_id).instance()
#	objects_node.add_child(enemy_scene)
#	enemy_scene.global_position = CENTER_POS
#	enemy_scene.scale = Vector2(3, 3)
#	enemy_scene.connect("object_pressed", self, "on_object_area_pressed")

func spawn_wave():
	# calculate the wave size: (num)
	var wave_size = boss_dic["wave_size"]
	randomize()
	var num = wave_size[0] + randi() % (wave_size[1] - wave_size[0] + 1)
	
	# a duplicate of enemy positions so you wouldn't be able to choose the same
	#  spot twice
	var e_poses = ENEMY_POSITIONS.duplicate(true)
	
	# num = how many enemies to spawn in this wave
	for i in range(0, num):
		# choose position (re-use the index var)
		var index = randi() % e_poses.size()
		var pos = e_poses[index]
		e_poses.remove(index) # so you won't get the same pos twice
		
		var e_id = math_util.get_random_key(boss_dic["enemies"])
		
		# load & instance the enemy:
		var enemy_scene = load(ENEMY_PATH % e_id).instance()
		objects_node.add_child(enemy_scene)
		enemy_scene.global_position = pos
		enemy_scene.connect("object_pressed", self, "on_object_area_pressed")
		enemy_scene.on_spawn()

# signal from object areas
# e_id is enemy id
func on_object_area_pressed(e_id):
	# show crafting window
	var e = enemies_data.get_enemy_by_id(e_id)
	hud.call_battle(e)
