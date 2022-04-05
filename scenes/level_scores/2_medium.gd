extends Node2D

var sfx_0
var sfx_1
var sfx_2 
var sfx_3

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_scores()
	var high_score = global.high_scores.medium
	var current_score = global.current_score
	
	var star_percent = Level_maps.levels[2]["star_scores"]
	var level_high = {}
	for star in star_percent:
		level_high[star] = floor(star_percent[star] * Level_maps.levels[2]["max_score"])
	print("Star Scores: " + str(level_high))
	
	var current_highest_streak = global.current_highest_streak
	sfx_0 = get_tree().get_root().get_node("persistent/sfx_lose_game")
	sfx_1 = get_tree().get_root().get_node("persistent/sfx_win_1_star")
	sfx_2 = get_tree().get_root().get_node("persistent/sfx_win_2_star")
	sfx_3 = get_tree().get_root().get_node("persistent/sfx_win_3_star")
		
	# Lose sfx
	if current_score < level_high["1_0"]:
		sfx_0.play()
	
	# Star rating gets updated based on score for level that was just completed
	for star in level_high:
		if current_score >= level_high[star]:
			$score_stars.set_animation(star)
			if star == "1_5" or star == "1_0":
				sfx_1.play()
			elif star == "2_5" or star == "2_0":
				sfx_2.play()
			else:
				sfx_3.play()
			break
			
	# Locking/unlocking of next level is based on high score
	if high_score > level_high["1_0"]:
		$button_next_locked.hide()
		$button_next.show()
	else:
		$button_next_locked.show()
		$button_next.hide()
	
	$score.set_bbcode("[right][color=black]" + str(current_score) + "[/color][/right]")
	$streak.set_bbcode("[right][color=black]" + str(current_highest_streak) + "[/color][/right]")
	$high_score.set_bbcode("[right][color=black]" + str(high_score) + "[/color][/right]")
	
func stop_sounds():
	if sfx_0.is_playing():
		sfx_0.stop()
	if sfx_1.is_playing():
		sfx_1.stop()
	if sfx_2.is_playing():
		sfx_2.stop()
	if sfx_3.is_playing():
		sfx_3.stop()
		
func _on_button_home_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_3").play()
	stop_sounds()
	get_tree().change_scene("res://scenes/home.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").play()


func _on_button_replay_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_1").play()
	stop_sounds()
	global.current_level = 2
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")


func _on_button__next_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_2").play()
	stop_sounds()
	global.current_level = 3
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
