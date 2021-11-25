extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#TODO: unlock next button if score higher than certain score
	#toggle visibility for button_next and button_next_locked
	#TODO: update score
	#$score.set_bbcode("[right][color=black]" + str(score) + "[/color][/right]")
	#TODO: update streak/combo meter
	#$streak.set_bbcode("[right][color=black]" + str(score) + "[/color][/right]")
	#TODO: set star rating
	#$score_stars.set_animation()
	#$score_stars.play()

func _on_button_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")


func _on_button_replay_pressed():
	global.current_level = 1
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")


func _on_button__next_pressed():
	global.current_level = 2
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
