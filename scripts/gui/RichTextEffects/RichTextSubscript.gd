tool
extends RichTextEffect
class_name RichTextSubscript

var bbcode := "sub"


func _process_custom_fx(char_fx):
	var off = char_fx.env.get("offset", 15)
	char_fx.offset = Vector2(0, +int(abs(off)))
	return true

