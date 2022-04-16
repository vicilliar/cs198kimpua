extends Node2D

var mins_played

# Called when the node enters the scene tree for the first time.
func _ready():
	if mins_played and mins_played > 0:
		$time_played.set_bbcode("[center]" + str(mins_played) + " minutes played[/center]")

func _on_background_pressed():
	get_tree().change_scene("res://scenes/home.tscn")
