extends Node2D
signal reskin(interval)

# TODO: keys overlap! find a way to fix this.
"""
# var notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']
# var black_keys = ['Db4', 'Eb4', 'Gb4', 'Ab4', 'Bb4']
# var chroma_notes = ['C4', 'Db4', 'D4', 'Eb4', 'E4', 'F4', 'Gb4',
#					'G4', 'Ab4', 'A4', 'Bb4', 'B4', 'C5']

# key represents 'note distance'

var intervals = {
					2: {'name': 'major_second', 	'folder': 2},
					4: {'name': 'major_third', 		'folder': 3}, 
					5: {'name': 'perfect_fourth', 	'folder': 4},
					7: {'name': 'perfect_fifth', 	'folder': 5},
					9: {'name': 'major_sixth', 		'folder': 6},
					11: {'name': 'major_seventh', 	'folder': 7},
					12: {'name': 'octave', 			'folder': 8}
				}
"""
var currently_playing = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set curr_key for all 8 keys
	for i in range(8):
		get_node(Consts.notes[i]).set_curr_key(i)


func _on_any_key_touched(key):
	if len(currently_playing) < 2:
		# Only allow 2 keys to play at any time.
		currently_playing.append(key)
		get_node(key).play_key()
		print("Currently Playing: " + str(currently_playing))
		
		if len(currently_playing) == 2:
			
			# Calculate distance between 2 notes and determine interval.
			var note_distance = abs(Consts.chroma_notes.find(currently_playing[1]) - Consts.chroma_notes.find(currently_playing[0]))
			print("Note Distance = " + str(note_distance))
			
			if note_distance in Consts.intervals:	
				print("Interval triggered!")
				print(Consts.intervals[note_distance])
				# Execute all interval changes here.
				emit_signal("reskin", Consts.intervals[note_distance])		# This is to alert parent (to change header skin)
				# Reskin all 8 keys
				for i in range(8):
					get_node(Consts.notes[i]).reskin_key(Consts.intervals[note_distance])
				for i in range(5):
					get_node(Consts.black_keys[i]).reskin_black_key(Consts.intervals[note_distance])
			
			else:
				print("No interval triggered.")
				

func _on_any_key_released(key):
	currently_playing.erase(key)
