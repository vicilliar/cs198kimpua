extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_scores()
	var easy = global.high_scores.easy
	var medium = global.high_scores.medium
	var hard = global.high_scores.hard

	for star in global.stars_scores_easy:
		if easy >= global.stars_scores_easy[star]:
			$easy_score.set_animation(star)
			break
			
	for star in global.stars_scores_medium:
		if medium >= global.stars_scores_medium[star]:
			$medium_score.set_animation(star)
			break
		elif easy >= global.stars_scores_easy["1_0"]:
			$medium_score.set_animation("0")
			$button_medium_locked.hide()
			$button_medium_locked/lock.hide()
		else:
			$button_medium.hide()

	for star in global.stars_scores_hard:
		if hard >= global.stars_scores_hard[star]:
			$hard_score.set_animation(star)
			break
		elif medium >= global.stars_scores_medium["1_0"]:
			$hard_score.set_animation("0")
			$button_hard_locked.hide()
			$button_hard_locked/lock.hide()
		else:
			$button_hard.hide()

func _on_easy_button_pressed():
	global.current_level = 1
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")

func _on_medium_button_pressed():
	global.current_level = 2
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
	
func _on_hard_button_pressed():
	global.current_level = 3
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
	
func _on_back_pressed():
	get_tree().change_scene("res://scenes/home.tscn")

