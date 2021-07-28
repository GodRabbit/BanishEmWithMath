extends VBoxContainer


# a scene that includes stats about an item.
# name, energy, price

var item_id = "none"

# formatting:
const HP_FORMATTING = "%d"
const PRICE_FORMATTING = "%d"

# nodes:
onready var name_label = $name_label
onready var hp_label = $hp_container/hp_label
onready var price_label = $price_container/price_label

# Called when the node enters the scene tree for the first time.
func _ready():
	name_label.text = ""
	hp_label.text = ""
	price_label.text = ""

func set_item_id(_item_id):
	item_id = _item_id
	update_gui()

func update_gui():
	var item_dict = items_data.get_item_by_id(item_id)
	
	if item_dict.size() == 0:
		name_label.text = "Unknown Item!"
		hp_label.text = "Unknown Item!"
		price_label.text = "Unknown Item!"
	else:
		name_label.text = item_dict["name"].capitalize()
		hp_label.text = HP_FORMATTING % item_dict["hp"]
		price_label.text = PRICE_FORMATTING % item_dict["price"]
