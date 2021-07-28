extends Node

class_name complex

# a class that represnts a complex number

var z = Vector2(0, 0)

func _init(real, imag):
	z = Vector2(real, imag)

func _to_string():
	if z.y > 0:
		if z.x != 0:
			return "%f +%fi" % [z.x, z.y]
		else:
			return "+%fi"
	elif z.y == 0:
		return str(z.x)
	elif z.y < 0:
		if z.x != 0:
			return "%f -%fi" % [z.x, -z.y]
		else:
			return "+%fi"
