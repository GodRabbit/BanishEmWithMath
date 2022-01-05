tool
extends RichTextEffect
class_name RichTextSubscript

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

var bbcode := "sub"


func _process_custom_fx(char_fx):
	var off = char_fx.env.get("offset", 15)
	char_fx.offset = Vector2(0, +int(abs(off)))
	return true

