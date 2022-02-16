extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_scores()
	var high_score = global.high_scores.easy
	var current_score = global.current_score
	var level_high = Level_maps.levels[1]["star_scores"]
	var current_highest_streak = global.current_highest_streak
	
	# Star rating gets updated based on score for level that was just completed
	for star in level_high:
		if current_score >= level_high[star]:
			$score_stars.set_animation(star)
			break
			
	# Locking/unlocking of next level is based on high score
	if high_score > level_high["1_0"]:
		$button_next_locked.hide()
	else:
		$button_next.hide()
	
	$score.set_bbcode("[right][color=black]" + str(current_score) + "[/color][/right]")
	$streak.set_bbcode("[right][color=black]" + str(current_highest_streak) + "[/color][/right]")

func _on_button_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")


func _on_button_replay_pressed():
	global.current_level = 1
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")


func _on_button__next_pressed():
	global.current_level = 2
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
