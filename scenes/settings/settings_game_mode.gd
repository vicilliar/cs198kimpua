extends Node2D
signal resume()
signal end_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_resume_pressed():
	emit_signal("resume")

func _on_slider_music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_button_end_pressed():
	emit_signal("end_game")
