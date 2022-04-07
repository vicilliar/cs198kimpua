extends Node

func _ready():
	global.high_scores.medium = 49500
	global.save_scores()
	

func on_zen_mode_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_3").play()
	get_tree().change_scene("res://scenes/modes/zen_mode.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").stop()


func _on_button_game_mode_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_2").play()
	get_tree().change_scene("res://scenes/level_selection.tscn")
