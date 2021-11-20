extends Node2D
signal key_touched(key)
signal key_released(key)

var curr_key = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_curr_key(i):
	curr_key = i
	var normal_texture = load("res://assets/images/scenes/zen_mode/1_main/keys/" + Consts.notes[curr_key] + ".png")
	# var pressed_texture_2nd = load("res://assets/images/scenes/zen_mode/1_main/keys/C.png")
	$key_touch_button.set_texture(normal_texture)
	# $key_touch_button.set_texture_pressed("bruh")
	# $key_area/AnimatedSprite.play(notes[curr_key] + "_unpressed")
	# $key_area/AnimatedSprite.play(notes[curr_key] + "_unpressed")
	

func _on_key_touch_button_pressed():
	# Send to keyboard first!
	emit_signal("key_touched", Consts.notes[curr_key])
	print(Consts.notes[curr_key] + " Touched")
	

func _on_key_touch_button_released():
	# Send to keyboard first!
	emit_signal("key_released", Consts.notes[curr_key])
	print(Consts.notes[curr_key] + " Released")


func play_key():
	var key_sound = get_node(Consts.notes[curr_key] + "_sound")
	key_sound.play()
	print(Consts.notes[curr_key] + " Playing")

func reskin_key(interval):
	var skins_folder = "res://assets/images/scenes/zen_mode/" + str(interval['folder']) + "_" + interval['name'] + "/keys/"
	var normal_texture = load(skins_folder + "unpressed.png")
	var pressed_texture = load(skins_folder + "pressed_" + Consts.notes[curr_key] + ".png")
	
	$key_touch_button.set_texture(normal_texture)
	$key_touch_button.set_texture_pressed(pressed_texture)


"""
func _on_key_area_key_clicked():
	print(notes[curr_key] + " Clicked")
	var key_sound = get_node(notes[curr_key] + "_sound")
	key_sound.play()
"""
