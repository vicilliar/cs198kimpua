extends Node

func _ready():
	# always play main menu music when we come back home.
	get_tree().get_root().get_node("persistent/main_menu_music").play()
	

func on_zen_mode_pressed():
	get_tree().get_root().get_node("persistent/sfx_zen_button").play()
	get_tree().change_scene("res://scenes/modes/zen_mode.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").stop()


func _on_button_game_mode_pressed():

	get_tree().get_root().get_node("persistent/sfx_button").play()
	get_tree().change_scene("res://scenes/level_selection.tscn")
