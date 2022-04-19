extends Node2D

var secs_played
var mins_played

# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_time()
	secs_played = global.total_time_played
	
	mins_played = secs_played/60
	
	if mins_played and mins_played > 0:
		if mins_played == 1:
			$time_played.set_bbcode("[center]" + str(mins_played) + " minute played[/center]")
		else:
			$time_played.set_bbcode("[center]" + str(mins_played) + " minutes played[/center]")

func _on_background_pressed():
	get_tree().change_scene("res://scenes/home.tscn")
