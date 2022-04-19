extends Node

var secs_played
var mins_played

func _ready():
	global.load_time()
	secs_played = global.total_time_played
	
	mins_played = secs_played/60
	
	if mins_played and mins_played > 0:
		if mins_played == 1:
			$time_played.set_bbcode("[center]" + str(mins_played) + " minute played[/center]")
		else:
			$time_played.set_bbcode("[center]" + str(mins_played) + " minutes played[/center]")
	

func on_zen_mode_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_3").play()
	get_tree().change_scene("res://scenes/modes/zen_mode.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").stop()


func _on_button_game_mode_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_2").play()
	get_tree().change_scene("res://scenes/level_selection.tscn")
