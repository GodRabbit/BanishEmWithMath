extends Node

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# global sound manager to prevent loss of audio while changing scenes

# nodes:
onready var ui_stream_player = $ui_stream_player
onready var music_stream_player = $music_stream_player
onready var anim = $anim

onready var button_click1 = preload("res://audio/ui/kenny/impactMetal_heavy_001.ogg")

onready var sfx_ids = {"button_click1": button_click1}

const audio_music_path = "res://audio/music/%s.ogg"

var current_music_id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	music_stream_player.connect("finished", self, "on_music_stream_player_finished")


func play_sound(id):
	if sfx_ids.has(id):
		sfx_ids[id].loop = false
		ui_stream_player.stream = sfx_ids[id]
		ui_stream_player.play()

func _change_music_track(id):
	if current_music_id == id && music_stream_player.playing:
		pass
	music_stream_player.stream = load(audio_music_path % id)

func play_music(id):
	current_music_id = id
	if music_stream_player.playing:
		anim.play("fade_out")
		yield(anim, "animation_finished")
		_change_music_track(id)
		anim.play("fade_in")
		music_stream_player.play()
	else:
		_change_music_track(id)
		music_stream_player.play()
		anim.play("fade_in")
		

func on_music_stream_player_finished():
	music_stream_player.play()
