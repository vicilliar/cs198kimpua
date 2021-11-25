extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_easy_button_pressed():
	global.current_level = 1
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")


func _on_back_pressed():
	get_tree().change_scene("res://scenes/home.tscn")

