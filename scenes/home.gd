extends Node

func _ready():
	pass # Replace with function body.

func on_zen_mode_pressed():
	get_tree().change_scene("res://scenes/modes/zen_mode.tscn")
