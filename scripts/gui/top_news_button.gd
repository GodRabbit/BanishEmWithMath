extends TextureButton

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui class for opening the the top news displayer

# nodes:
onready var notification_particles = $notification_particles

# Called when the node enters the scene tree for the first time.
func _ready():
	update_gui()


func update_gui():
	if player_data.get_news_notification() && game_settings.get_enable_news_notifications():
		notification_particles.emitting = true
	else:
		notification_particles.emitting = false
