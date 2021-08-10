tool
extends RichTextEffect
class_name RichTextSuperscript

var bbcode := "sup"


func _process_custom_fx(char_fx):
	var off = char_fx.env.get("offset", 15)
	char_fx.offset = Vector2(0, -int(abs(off)))
	# char_fx.character = 6
	return true
