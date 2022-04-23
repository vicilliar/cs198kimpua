# Global variables go here. Will be retained even after scene changes.
extends Node

var current_level = 1	# level 1 by default
var current_score
var current_highest_streak
var total_time_played
var _timer = null

var high_scores = {
	"easy": 0,
	"medium": 0,
	"hard": 0
}

func _ready():
	load_time()
	_timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
func _on_Timer_timeout():
	save_time()
	
func save_time():
	total_time_played += 1
	
	var time_file = File.new()
	time_file.open("user://time_played.cfg", File.WRITE)
	time_file.store_line(str(total_time_played))
	time_file.close()
	
func load_time():
	var time_file = File.new()
	if not time_file.file_exists("user://time_played.cfg"):
		save_time()
		return
	time_file.open("user://time_played.cfg", File.READ)
	total_time_played = int(time_file.get_as_text())

func save_scores():
	var score_file = File.new()
	score_file.open("user://high_scores.cfg", File.WRITE)
	score_file.store_line(to_json(high_scores))
	score_file.close()
	
	#HOW TO SAVE
	#global.high_scores.easy = score
	#global.save_scores()
	
func load_scores():
	var score_file = File.new()
	if not score_file.file_exists("user://high_scores.cfg"):
		save_scores()
		return
	score_file.open("user://high_scores.cfg", File.READ)
	var data = parse_json(score_file.get_as_text())

	high_scores.easy = data.easy
	high_scores.medium = data.medium
	high_scores.hard = data.hard
	
	#HOW TO LOAD
	#global.load_scores()
	#var score = global.high_scores.easy 
