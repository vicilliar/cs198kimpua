extends Node2D
signal confirm_end_game()
signal cancel_end_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_exit_pressed():
	emit_signal("confirm_end_game")

func _on_button_cancel_pressed():
	emit_signal("cancel_end_game")
