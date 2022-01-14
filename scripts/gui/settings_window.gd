extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for the settings window in the game. Used to change the sound settings.

# nodes:
# sound nodes:
onready var master_slider = $main_panel/main_container/master_volume_box/master_slider
onready var music_slider = $main_panel/main_container/music_volume_box/music_slider
onready var sfx_slider = $main_panel/main_container/sfx_volume_box/sfx_slider
onready var ui_slider  = $main_panel/main_container/ui_volume_box/ui_slider

# ui nodes:
onready var show_timer_checkbox = $main_panel/main_container/timer_box/show_timer_checkbox

# buttons nodes:
onready var save_button = $main_panel/main_container/button_container/save_button
onready var cancel_button = $main_panel/main_container/button_container/cancel_button

# signals:
signal request_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	save_button.connect("pressed", self, "on_save_button_pressed")
	cancel_button.connect("pressed", self, "on_cancel_button_pressed")
	update_gui()

# updates the gui: 
func update_gui():
	# set the sliders to represnt the current game settings:
	master_slider.value = game_settings.get_audio_level("master")
	music_slider.value = game_settings.get_audio_level("music")
	sfx_slider.value = game_settings.get_audio_level("sfx")
	ui_slider.value = game_settings.get_audio_level("ui")

func on_save_button_pressed():
	# save the data in the settings:
	# sound settings:
	game_settings.set_audio_level("master", int(master_slider.value))
	game_settings.set_audio_level("music", int(music_slider.value))
	game_settings.set_audio_level("sfx", int(sfx_slider.value))
	game_settings.set_audio_level("ui", int(ui_slider.value))
	
	# ui settings:
	game_settings.set_timer_shown(show_timer_checkbox.pressed)
	emit_signal("request_exit")

func on_cancel_button_pressed():
	emit_signal("request_exit")


