# Global variables go here. Will be retained even after scene changes.
extends Node

var current_level = 1	# level 1 by default
var current_score

# TODO, remove these and use the ones in level_maps
var stars_scores_easy = {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100}
var stars_scores_medium = {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100}
var stars_scores_hard = {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100}

var high_scores = {
	"easy": 0,
	"medium": 0,
	"hard": 0
}

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