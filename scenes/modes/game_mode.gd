extends Node2D

var score
var combo_meter
var live_notes			# list of dictionaries representing live notes: name, click_indicator, & click_timer. start and end also included just in case!
var note_list			# list of dictionaries of level notes and their details
var next_notes_to_spawn	# list of indices of note_list to spawn next
var last_wait_time

export (PackedScene) var Click_Indicator
# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	play_level(global.current_level)
	get_node("game_mode_header").default_header("game_mode")


func _on_reskin(interval):
	print("Interval check: ", interval)
	get_node("game_mode_header").reskin_header(interval, "game_mode")
	for x in self.get_children():
		print(x.name)


func on_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")


func fill_next_notes(length, first_check):
	next_notes_to_spawn = []
	var last_start_time
	var i = first_check
	if i < length:
		last_start_time = note_list[i]["start"]
		next_notes_to_spawn.append(i)
		i += 1
	
	# Keep going while the start times are still the same.
	while i < length:
		# Cut the list off here.
		if note_list[i]["start"] > last_start_time:
			break
		else:
			next_notes_to_spawn.append(i)
			i += 1
	
	print("Next To Spawn: " + str(next_notes_to_spawn))
		

func initialize(level_num):
	# reset all starting variables
	note_list = Level_maps.levels[level_num]["notes"]
	print("Note List: " + str(note_list))
	score = 0
	update_scoreboard()
	combo_meter = 0
	live_notes = []
	next_notes_to_spawn = []
	
	
func play_level(level_num):
	initialize(level_num)
	fill_next_notes(len(note_list), 0)
	
	last_wait_time = note_list[next_notes_to_spawn[0]]["start"]
	$spawn_timer.set_wait_time(last_wait_time)
	$spawn_timer.start()
		

func generate_next_notes():
	for i in next_notes_to_spawn:
		# note is stored as: details (from note_list), click_indicator, & click_timer.
		var note_name = note_list[i]["name"]
		
		# spawn a click_indicator
		var new_click_indicator = Click_Indicator.instance()
		# TODO: set the interval_state properly
		new_click_indicator.interval_state = 1
		new_click_indicator.position.x = Consts.C4_click_position + (Consts.key_width * 	Consts.notes.find(note_name))		# x is factor of what note it is
		new_click_indicator.position.y = Consts.click_y			# constant y
		add_child(new_click_indicator)
		
		# spawn a timer for 2s
		var new_click_timer = Timer.new()
		add_child(new_click_timer)
		new_click_timer.connect("timeout", self,"_on_click_timer_timeout", [new_click_timer])
		new_click_timer.set_wait_time(Consts.click_timer_length)
		new_click_timer.start()
		
		# store the live note
		live_notes.append({	"details": note_list[i],
							"click_indicator": new_click_indicator,
							"click_timer": new_click_timer
							})
		print("Spawned new note. Live Notes: " + str(live_notes))


func update_scoreboard():
	# TODO aimee: Implement scoreboard display here!
	$temp_score.set_text("SCORE: " + str(score))
	print("Current score: " + str(score))
	

func despawn_live_note(note, action):
	print("Despawning " + str(note) + ". Reason: " + str(action))
	note["click_indicator"].final_animation(action)	# kill indicator
	live_notes.erase(note)							# despawn note
	print("Live Notes: " + str(live_notes))
	
	
func _on_spawn_timer_timeout():
	# In charge of spawning the next notes to play
	generate_next_notes()
	fill_next_notes(len(note_list), next_notes_to_spawn[-1] + 1)
	
	if not next_notes_to_spawn.empty():
		last_wait_time = note_list[next_notes_to_spawn[0]]["start"] - last_wait_time
		$spawn_timer.set_wait_time(last_wait_time)
		$spawn_timer.start()
	else:
		print("Level Over! All notes spawned.")
		$spawn_timer.stop()


func _on_click_timer_timeout(timer):
	# FAILED. find the appropriate live_notes item
	for note in live_notes:
		if timer == note["click_timer"]:
			print("Timed Out!")
			despawn_live_note(note, "timed_out")
			break


func _on_keyboard_key_played(key):
	for note in live_notes:
		if key == note["details"]["name"]:
			# correct note was played! now check if it was in time.
			if note["click_timer"].get_time_left() < Consts.correct_click_window:
				print("Correct press!" + key)
				score += 100
				update_scoreboard()
				despawn_live_note(note, "correct")
				return
			else:
				# Wrong: WRONG TIMING (kill all notes)
				print("Wrong! Wrongly timed press.")
				for note_to_despawn in live_notes:
					despawn_live_note(note_to_despawn, "wrong")
				return

	# Wrong: WRONG NOTE PLAYED (kill all notes)
	print("Wrong! Wrong note played.")
	for note_to_despawn in live_notes:
		despawn_live_note(note_to_despawn, "wrong")

	
# TODO: level high scores saved to FILE. if empty, default high score is 0. Also save to file if COMPLETED or not.

