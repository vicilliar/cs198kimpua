extends Node2D
signal resume()

# Called when the node enters the scene tree for the first time.
func _ready():
	$slider_keys.value = db2linear(AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("Keys")
	))
	$slider_bgm.value = db2linear(AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("BGM")
	))

func _on_button_resume_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_2").play()
	emit_signal("resume")

func _on_slider_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear2db(value))

func _on_slider_keys_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear2db(value))
