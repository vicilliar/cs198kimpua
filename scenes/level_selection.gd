extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_easy_button_pressed():
	get_tree().change_scene("res://scenes/modes/zen_mode.tscn")


func _on_back_pressed():
	get_tree().change_scene("res://scenes/home.tscn")
