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

	for star in easy_stars:
		if easy >= easy_stars[star]:
			$easy_score.set_animation(star)
			$easy_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(easy) + "[/color][/center]")
			break
			
	for star in medium_stars:
		if medium >= medium_stars[star]:
			$medium_score.set_animation(star)
			$button_medium_locked.hide()
			$button_medium_locked/lock.hide()
			$medium_hs.show()
			$medium_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(medium) + "[/color][/center]")
			break
		elif easy >= easy_stars["1_0"]:
			$medium_score.set_animation("0")
			$button_medium_locked.hide()
			$button_medium_locked/lock.hide()
		else:
			$button_medium.hide()
			$button_medium_locked.show()
			$button_medium_locked/lock.show()

	for star in high_stars:
		if hard >= high_stars[star]:
			$hard_score.set_animation(star)
			$button_hard_locked.hide()
			$button_hard_locked/lock.hide()
			$hard_hs.show()
			$hard_hs.set_bbcode("[center][color=black]HIGH SCORE: " + str(hard) + "[/color][/center]")
			break
		elif medium >= medium_stars["1_0"]:
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
