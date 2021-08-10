extends Button

class_name RichTextButton

# Cannot be done without breaking your head on the brick wall that is Godot gui.
# Don't even bother, find other solutions.
# A button class for displaying rich text labels inside buttons, with bbcode
# and everything. The button size will change the rich text inside and so on.

export var bbcode_text = ""
#export var text_margin_left = 0 
#export var text_margin_right = 0
#export var text_margin_top = 0
#export var text_margin_bot = 0

# nodes:
onready var text_container = $text_container # margin container
onready var rich_text_label = $text_container/rtl

# Called when the node enters the scene tree for the first time.
func _ready():
	text_container.connect("resized", self, "on_text_container_resized")
	on_text_container_resized()

func set_text(t):
	bbcode_text = t
	rich_text_label.bbcode_text = t
	on_text_container_resized()

# signal
# the rich text label changed its size:
func on_text_container_resized():
	set_size(rich_text_label.get_global_rect().size+Vector2(10,10))
	rich_text_label.set_anchors_and_margins_preset(Control.PRESET_CENTER)
