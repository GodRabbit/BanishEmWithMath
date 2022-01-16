extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for "high score" (Honourable sacrifices) entry

class_name hs_entry

var difficulty = "NORMAL"
var zone = "zone1"
var time = 10000000 # in miliseconds; how much time it took the player to finish the game
var stars = 300
var date # the date of the record

func _init(_zone, _difficulty, _time, _stars, _date):
	zone = _zone
	difficulty = _difficulty
	time = _time
	stars = _stars
	date = _date

func get_time():
	return time

func get_zone():
	return zone

func get_difficulty():
	return difficulty

func get_stars():
	return stars

func get_date():
	return date

# compare this entry to another entry's time
# return 1 if greater, -1 if lower and 0 if equal
func compare(_time):
	if time > _time:
		return 1
	elif time < _time:
		return -1
	else:
		return 0

# return a formatting of the time into a string
func format_time():
	var time_dic = math_util.ms_to_time_dictionary(time)
	var s = "%02d:%02d:%02d.%d" % [time_dic["hrs"], time_dic["mnts"], time_dic["secs"], time_dic["ms"]]
	return s

func _to_string():
	var s = "(%d %s '%d) %s Difficulty ; %s" % [date["day"], 
	math_util.get_month_abbr_from_number(date["month"]), 
	date["year"] % 1000, 
	difficulty, 
	format_time()]
	return s
