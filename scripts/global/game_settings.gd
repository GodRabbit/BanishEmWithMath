extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

signal audio_settings_changed(channel)

var settings = {
	"audio":{ # audio settings from 0 ,1, 2,  3
		"master":2, 
		"music":3, 
		"sfx":3, 
		"ui":3  
	},
	"ui":{
		"show_timer":false,
		"enable_news_notifications":true, # whether the phone move anytime the player get notifications
		"show_news":true # whether the entire news section are enabled or disabled
	},
	"game_data":{
		"version":"0.2.0-beta",
		"debug_mode":false,
		"allow_cheating":false
	}
}

var audio_levels = [-56, -37, -18, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_audio_level(channel_id, num):
	settings["audio"][channel_id] = num % 4
	emit_signal("audio_settings_changed", channel_id)

func get_audio_level(channel_id):
	return settings["audio"][channel_id]

func get_audio_db(channel_id):
	# the db according to the levels:
	var audio_db = audio_levels[settings["audio"][channel_id]]
	
	# mix with master and return the answer:
	return _transform(get_audio_level("master"), audio_db)

func _db_to_percent(db):
	return 100.0 + (100.0/56.0)*db

func _percent_to_db(p):
	return (56.0*p - 5600.0)/100.0

# linear transform for the master audio levels:
# get audio_level between 0 to 3 and db, and returns
# the new db 
func _transform(audio_level, audio_db):
	# the audio levels as percents
	var audio_level_percent = (100.0/3.0)*audio_level
	
	# now we transform audio_db into an easy scalable so we can use
	# percents on it
	var audio_percent = _db_to_percent(audio_db)
	
	# get the new percent and return it into db
	var new_db = _percent_to_db(audio_percent*audio_level_percent/100.0)
	
	return new_db

func get_setting(sett_id):
	return settings[sett_id]

func is_timer_shown():
	return get_setting("ui")["show_timer"]

func set_timer_shown(val : bool):
	settings["ui"]["show_timer"] = val

func get_enable_news_notifications():
	return get_setting("ui")["enable_news_notifications"]

func set_enable_news_notifications(val : bool):
	settings["ui"]["enable_news_notifications"] = val

func get_show_news():
	return get_setting("ui")["show_news"]

func set_show_news(val : bool):
	settings["ui"]["show_news"] = val
