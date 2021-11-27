extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_scores()
	var high_score = global.high_scores.hard
	var current_score = global.current_score
	
	# Star rating gets updated based on score for level that was just completed
	for star in global.stars_scores_hard:
		if current_score >= global.stars_scores_hard[star]:
			$score_stars.set_animation(star)
			break
			
	# Locking/unlocking of next level is based on high score
	if high_score > global.stars_scores_hard["1_0"]:
		$button_next_locked.hide()
	else:
		$button_next.hide()
	
	$score.set_bbcode("[right][color=black]" + str(current_score) + "[/color][/right]")
	#TODO: update streak/combo meter
	#$streak.set_bbcode("[right][color=black]" + str(score) + "[/color][/right]")

func _on_button_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")


func _on_button_replay_pressed():
	global.current_level = 3
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")

