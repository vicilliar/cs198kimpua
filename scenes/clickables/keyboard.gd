extends Node2D
# var Key = load("key.tcsn")
var notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']


# Called when the node enters the scene tree for the first time.
func _ready():
	$C4.set_curr_key(0)
	$D4.set_curr_key(1)
	$E4.set_curr_key(2)
	$F4.set_curr_key(3)
	$G4.set_curr_key(4)
	$A4.set_curr_key(5)
	$B4.set_curr_key(6)
	$C5.set_curr_key(7)


# func generate_key(i):
	# var new_key = Key.instance()
	# new_key.curr_key = i
	
	# This is what we have to figure out! Positioning how?
	# new_key.position.x = 0
	# new_key.position.y = 0
		
	# add_child(new_key)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
