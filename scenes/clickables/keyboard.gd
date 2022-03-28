extends Node2D
signal reskin(interval)
signal key_played(key)

# TODO: keys overlap! find a way to fix this.

var currently_playing = []
var current_mode
var is_correct_interval = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set curr_key for all 8 keys
	for i in range(8):
		get_node(Consts.notes[i]).set_curr_key(i)
	current_mode = get_parent().get_name()

func check_reskin(feedback):
	is_correct_interval = feedback
	print("Checked Feedback: ", is_correct_interval)

func _on_any_key_touched(key):
	if len(currently_playing) < 2:
		# Only allow 2 keys to play at any time.
		currently_playing.append(key)
		get_node(key).play_key()
		emit_signal("key_played", key)
		print("Currently Playing: " + str(currently_playing))
		
		if len(currently_playing) == 2:
			if (current_mode == 'game_mode' and is_correct_interval == true) or (current_mode == 'zen_mode'):
			
				# Calculate distance between 2 notes and determine interval.
				var note_distance = abs(Consts.chroma_notes.find(currently_playing[1]) - Consts.chroma_notes.find(currently_playing[0]))
				print("Note Distance = " + str(note_distance))
				
				if note_distance in Consts.intervals:	
					# print("Interval triggered!")
					# print(Consts.intervals[note_distance])
					# Execute all interval changes here.
					emit_signal("reskin", Consts.intervals[note_distance])		# This is to alert parent (to change header skin)
					# Reskin all 8 keys
					for i in range(8):
						get_node(Consts.notes[i]).reskin_key(Consts.intervals[note_distance])
					for i in range(5):
						get_node(Consts.black_keys[i]).reskin_black_key(Consts.intervals[note_distance])
			
			else:
				pass
				# print("No interval triggered.")
				

func _on_any_key_released(key):
	currently_playing.erase(key)
