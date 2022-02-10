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
		

func on_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")


func _on_button_settings_pressed():
	get_node("settings_screen").show()
	get_tree().set_deferred("paused", true)


func _on_settings_screen_resume():
	get_node("settings_screen").hide()
	get_tree().set_deferred("paused", false)
