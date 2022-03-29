extends Node2D
signal resume()
signal end_game()

var exit_type

# Called when the node enters the scene tree for the first time.
func _ready():
	$slider_keys.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("Keys")
	)
	$slider_bgm.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("BGM")
	)
	$slider_sfx.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("SFX")
	)

func _on_button_resume_pressed():
	emit_signal("resume")

func _on_slider_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)

func _on_slider_keys_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Keys"), value)

func _on_slider_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_button_end_pressed():
	exit_type = "exit"
	get_node("confirm_action").show()

func _on_confirm_action_cancel_end_game():
	get_node("confirm_action").hide()
	emit_signal("resume")

func _on_confirm_action_confirm_end_game():
	get_node("confirm_action").hide()
	emit_signal("end_game")

func _on_button_restart_pressed():
	exit_type = "restart"
	get_node("confirm_action").show()

func _on_confirm_action_confirm_restart():
	emit_signal("resume")
	get_tree().change_scene("res://scenes/modes/game_mode.tscn")
