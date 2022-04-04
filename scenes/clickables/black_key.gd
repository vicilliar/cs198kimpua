extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func reskin_black_key(interval):
	var skins_folder = "res://assets/images/scenes/zen_mode/" + str(interval['folder']) + "_" + interval['name'] + "/keys/"
	var normal_texture = load(skins_folder + "black.png")
	
	$black_key_touch_button.set_texture(normal_texture)
	$black_key_touch_button.set_texture_pressed(normal_texture)

func reset_black_key(i):
	var skins_folder = "res://assets/images/scenes/zen_mode/1_main/keys/"
	var normal_texture = load(skins_folder + "black.png")
	
	$black_key_touch_button.set_texture(normal_texture)
	$black_key_touch_button.set_texture_pressed(normal_texture)
