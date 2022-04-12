extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_scores()
	var easy = global.high_scores.easy
	var medium = global.high_scores.medium
	var hard = global.high_scores.hard
	
	var easy_stars = Level_maps.levels[1]["star_scores"]
	var medium_stars = Level_maps.levels[2]["star_scores"]
	var high_stars = Level_maps.levels[3]["star_scores"]
	
	var level_high_1 = {}
	for star in easy_stars:
		level_high_1[star] = floor(easy_stars[star] * Level_maps.levels[1]["max_score"])
		
	var level_high_2 = {}
	for star in medium_stars:
		level_high_2[star] = floor(medium_stars[star] * Level_maps.levels[1]["max_score"])
		
	var level_high_3 = {}
	for star in high_stars:
		level_high_3[star] = floor(high_stars[star] * Level_maps.levels[1]["max_score"])
	
	

	for star in level_high_1:
		if easy >= level_high_1[star]:
			$easy_score.set_animation(star)
			$easy_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(easy) + "[/color][/center]")
			break
	if easy < level_high_1["1_0"]:
		$easy_score.set_animation("0")
		if easy > 0:
			$easy_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(easy) + "[/color][/center]")
			
			
	for star in level_high_2:
		if medium >= level_high_2[star]:
			$medium_score.set_animation(star)
			$button_medium_locked.hide()
			$button_medium_locked/lock.hide()
			$medium_hs.show()
			$medium_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(medium) + "[/color][/center]")
			break
		elif easy >= level_high_1["1_0"]:
			$medium_score.set_animation("0")
			$button_medium_locked.hide()
			$button_medium_locked/lock.hide()
		else:
			$button_medium.hide()
			$button_medium_locked.show()
			$button_medium_locked/lock.show()

	for star in level_high_3:
		if hard >= level_high_3[star]:
			$hard_score.set_animation(star)
			$button_hard_locked.hide()
			$button_hard_locked/lock.hide()
			$hard_hs.show()
			$hard_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(hard) + "[/color][/center]")
			break
		elif medium >= level_high_2["1_0"]:
			$hard_score.set_animation("0")
			$button_hard_locked.hide()
			$button_hard_locked/lock.hide()
		else:
			$button_hard.hide()
			$button_hard_locked.show()
			$button_hard_locked/lock.show()


func _on_level_button_pressed(clicked_level):
	get_tree().get_root().get_node("persistent/sfx_button_1").play()
	global.current_level = clicked_level
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").stop()
	
	
func _on_back_pressed():
	get_tree().get_root().get_node("persistent/sfx_pause_button").play()
	get_tree().change_scene("res://scenes/home.tscn")
