extends MarginContainer


# a gui for the money counter

# nodes:
onready var number_label = $Background/Number


# Called when the node enters the scene tree for the first time.
func _ready():
	player_data.connect("money_changed", self, "on_money_changed")
	
	update_gui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_gui():
	number_label.text = str(player_data.get_money())

func on_money_changed():
	update_gui()
