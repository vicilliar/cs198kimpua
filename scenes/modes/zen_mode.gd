extends Node2D

# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_reskin(interval):
	print("Interval check: ", interval)
	get_node("zen_mode_header").reskin_header(interval, "zen_mode")
	for x in self.get_children():
		print(x.name)
	$keyboard_reset.start()
		

func on_home_pressed():
	get_tree().get_root().get_node("persistent/sfx_button_3").play()
	get_tree().change_scene("res://scenes/home.tscn")
	get_tree().get_root().get_node("persistent/main_menu_music").play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Keys"), 0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), 0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), 0)
	

func _on_button_settings_pressed():
	get_tree().get_root().get_node("persistent/sfx_pause_button").play()
	get_node("settings_screen").show()
	get_tree().set_deferred("paused", true)


func _on_settings_screen_resume():
	get_node("settings_screen").hide()
	get_tree().set_deferred("paused", false)


func _on_keyboard_reset_timeout():
	get_node("keyboard").reset_keyboard()
	get_node("zen_mode_header").reskin_header(Consts.intervals[0], "zen_mode")
