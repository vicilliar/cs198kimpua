extends Node2D
var Key = load("key.tcsn")
var notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']


# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate 8 keys as children (from C4 to C5)
	for i in range(8):
		generate_key(i)
	pass # Replace with function body.


func generate_key(i):
	var new_key = Key.instance()
	new_key.curr_key = i
	
	# This is what we have to figure out! Positioning how?
	new_key.position.x = 0
	new_key.position.y = 0
		
	add_child(new_key)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
