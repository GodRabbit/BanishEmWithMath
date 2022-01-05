extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# A class that represnts a basic expression (2 numbers and operator).

enum OPERATORS {
	PLUS,
	MINUS,
	MULT,
	DIV,
	POW
}

var num1 = 0
var num2 = 0
var op = OPERATORS.PLUS


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
