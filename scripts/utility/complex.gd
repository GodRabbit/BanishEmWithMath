extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
