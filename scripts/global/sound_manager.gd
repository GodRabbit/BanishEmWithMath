extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# global sound manager to prevent loss of audio while changing scenes

# nodes:
onready var ui_stream_player = $ui_stream_player
onready var music_stream_player = $music_stream_player
onready var sfx_stream_player = $sfx_stream_player
onready var anim = $anim

onready var button_click1 = preload("res://audio/ui/kenny/impactMetal_heavy_001.ogg")
onready var ui_success = preload("res://audio/sfx/gabrielaraujo__success.ogg")
onready var sfx_swoosh1 = preload("res://audio/sfx/swoosh-6428.ogg")
onready var sfx_negative = preload("res://audio/sfx/negative.ogg")

onready var sfx_ids = {"button_click1": button_click1, 
"ui_success":ui_success, "sfx_swoosh1":sfx_swoosh1, "sfx_negative":sfx_negative}

const audio_music_path = "res://audio/music/%s/%s.ogg"

var current_music_id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	music_stream_player.connect("finished", self, "on_music_stream_player_finished")
	game_settings.connect("audio_settings_changed", self, "on_audio_setting_change")
	on_audio_setting_change("music")
	on_audio_setting_change("sfx")
	on_audio_setting_change("ui")


func play_ui_sound(id):
	if sfx_ids.has(id):
		sfx_ids[id].loop = false
		ui_stream_player.stream = sfx_ids[id]
		ui_stream_player.play()

func play_sfx_sound(id):
	if sfx_ids.has(id):
		sfx_ids[id].loop = false
		sfx_stream_player.stream = sfx_ids[id]
		sfx_stream_player.play()

func _change_music_track(folder_name, id):
	if current_music_id == id && music_stream_player.playing:
		pass
	music_stream_player.stream = load(audio_music_path % [folder_name, id])

func play_music(folder_name, id):
	current_music_id = id
	if music_stream_player.playing:
		anim.play("fade_out")
		yield(anim, "animation_finished")
		_change_music_track(folder_name, id)
		anim.play("fade_in")
		music_stream_player.play()
	else:
		_change_music_track(folder_name, id)
		music_stream_player.play()
		anim.play("fade_in")
		

func on_music_stream_player_finished():
	music_stream_player.play()

# called when the game settings changed
func on_audio_setting_change(channel):
	match channel:
		"music","master":
			# get the volume for the channel in the settings:
			var db = game_settings.get_audio_db("music")
			music_stream_player.volume_db = db
			
			# set the correct volume in the fade in and fade outs animations:
			var fade_in_anim = anim.get_animation("fade_in")
			var idx = fade_in_anim.find_track("music_stream_player:volume_db")
#			print("track found at " +str(idx))
			fade_in_anim.track_set_key_value(idx, 1, db)
	
			var fade_out_anim = anim.get_animation("fade_out")
			var idx2 = fade_out_anim.find_track("music_stream_player:volume_db")
			fade_out_anim.track_set_key_value(idx2, 0, db)
		"ui","master":
			# get the volume for the channel in the settings:
			var db = game_settings.get_audio_db("ui")
			ui_stream_player.volume_db = db
		"sfx","master":
			var db = game_settings.get_audio_db("sfx")
			sfx_stream_player.volume_db = db
