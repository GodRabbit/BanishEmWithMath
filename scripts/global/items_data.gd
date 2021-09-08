extends Node


var items_data = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data/items_data.json", file.READ)
	var text = file.get_as_text()
	var res = JSON.parse(text) #parse text to dictionary
	items_data = res.result #save the result
	file.close() #close file

func get_random_item_id():
	randomize()
	var index = randi() % items_data.keys().size()
	var key = items_data.keys()[index]
	return key

func get_item_by_id(id):
	if items_data.has(id):
		return items_data[id]
	else:
		return {}