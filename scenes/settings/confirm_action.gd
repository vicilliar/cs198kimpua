extends Node2D
signal confirm_end_game()
signal confirm_restart()
signal cancel_end_game()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_exit_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_3").play()
	if get_parent().exit_type == "restart":
		emit_signal("confirm_restart")
	else:
		emit_signal("confirm_end_game")

func _on_button_cancel_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_2").play()
	emit_signal("cancel_end_game")
