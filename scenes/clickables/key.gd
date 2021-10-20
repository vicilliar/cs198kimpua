extends Node2D
var notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']
var curr_key = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_curr_key(i):
	curr_key = i
	$key_area/AnimatedSprite.play(notes[curr_key] + "_unpressed")
	
func _on_key_area_key_clicked():
	print(notes[curr_key] + " Clicked")
	var key_sound = get_node(notes[curr_key] + "_sound")
	key_sound.play()
