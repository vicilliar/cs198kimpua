extends Node2D

func _ready():
	$name.hide() # Replace with function body.

func default_header(mode):
	var skins_folder = "res://assets/images/scenes/" + mode + "/1_main/"
	var normal_texture = load(skins_folder + "header_no_stripe.png")
	
	$header_button.set_normal_texture(normal_texture)
	$header_button.set_pressed_texture(normal_texture)
	
	var stripe = "1_main"
	$stripe.play(stripe)
	$name.hide()
	

func reskin_header(interval, mode):
	var skins_folder
	var normal_texture
	if interval['folder'] == 1:
		default_header(mode)
	else:
		var stripe = str(interval['folder']) + "_" + interval['name']
		skins_folder = "res://assets/images/scenes/" + mode + "/" + str(interval['folder']) + "_" + interval['name'] + "/"
		normal_texture = load(skins_folder + "header_no_stripe.png")
		$header_button.set_normal_texture(normal_texture)
		$header_button.set_pressed_texture(normal_texture)
		$stripe.play(stripe)
		$name.show()
		$name.play(stripe)
	
	var bitmap_img = Image.new()
	bitmap_img.load("res://assets/images/scenes/" + mode + "/header_bitmap.png")
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(bitmap_img)
	
	$header_button.set_click_mask(bitmap)
	

func _on_header_pressed():
	print("Header Touched")

func _on_name_animation_finished():
	$name.stop()
	$name.hide()
