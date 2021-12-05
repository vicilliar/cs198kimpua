extends Node2D

var score
var combo_meter
var live_notes			# list of dictionaries representing live notes: name, click_indicator, & click_timer. start and end also included just in case!
var note_list			# list of dictionaries of level notes and their details
var last_spawn_time
var elapsed_time
var level_music_time	# bgm duration
var level_name = {1:"easy", 2:"medium", 3:"hard"}
var next_note_index
var current_interval_state = 1


export (PackedScene) var Click_Indicator
# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	play_level(global.current_level)
	get_node("game_mode_header").default_header("game_mode")


func _process(delta):
	# Check if there's a note to spawn
	elapsed_time = level_music_time - $level_music_timer.get_time_left()
	while (next_note_index < len(note_list)) and (abs(elapsed_time - note_list[next_note_index]["start"]) < delta):
		# Spawn the next note!
		generate_new_note(note_list[next_note_index])
		next_note_index += 1
			
	
func _on_reskin(interval):
	# print("Interval check: ", interval)
	get_node("game_mode_header").reskin_header(interval, "game_mode")
	current_interval_state = interval['folder']
	for x in self.get_children():
		pass
		# print(x.name)


func on_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")
		

func offset_note_timings(raw_note_list, offset):
	var new_note_list = []
	for note in raw_note_list:
		new_note_list.append(
			{
				"name": note["name"],
				"hold": note["hold"],
				"start": note["start"] + offset - (Consts.click_timer_length - (Consts.correct_click_window / 2)),
				"length": note["length"]
			}
		)
	return new_note_list


func initialize(level_num):
	# reset all starting variables
	var raw_note_list = Level_maps.levels[level_num]["notes"]
	note_list = offset_note_timings(raw_note_list, Level_maps.levels[level_num]["start_time_offset"])
	
	print("Note List: " + str(note_list))
	score = 0
	update_scoreboard()
	combo_meter = 0
	live_notes = []
	next_note_index = 0
	
	var curr_bgm = load(Level_maps.levels[level_num]["bg_music"])
	$level_bgm_player.stream = curr_bgm
	$level_bgm_player.play()
	
	level_music_time = Level_maps.levels[level_num]["level_time"]
	$level_music_timer.set_wait_time(level_music_time)
	$level_music_timer.start()
	
	
func play_level(level_num):
	initialize(level_num)
	
		
func generate_new_note(note):
	# note is stored as: details (from note_list), click_indicator, & click_timer.
	var note_name = note["name"]
	
	# spawn a click_indicator
	var new_click_indicator = Click_Indicator.instance()
	# TODO: set the interval_state properly
	new_click_indicator.interval_state = current_interval_state
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
	live_notes.append({	"details": note,
						"click_indicator": new_click_indicator,
						"click_timer": new_click_timer
						})
	print("Spawned new note. Live Notes: " + str(live_notes))


func update_scoreboard():
	# TODO aimee: Implement scoreboard display here!
	# TODO aimee: Added score edit when combo meter is available
	$temp_score.set_bbcode("[right]" + str(score) + "[/right]")
	if (score != 0):
		$added_score.set_bbcode("[right][wave amp=80]+100[/wave][/right]")
		$added_score_timer.start()
	print("Current score: " + str(score))
	

func despawn_live_note(note, action):
	# print("Despawning " + str(note) + ". Reason: " + str(action))
	note["click_indicator"].final_animation(action)	# kill indicator
	live_notes.erase(note)							# despawn note
	# print("Live Notes: " + str(live_notes))
	

func _on_click_timer_timeout(timer):
	# FAILED. find the appropriate live_notes item
	for note in live_notes:
		if timer == note["click_timer"]:
			print("Timed Out!")
			despawn_live_note(note, "timed_out")
			break


func _on_added_score_timer_timeout():
	$added_score.set_bbcode("")


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
func _on_level_music_timer_timeout():
	$level_music_timer.stop()
	
	if score > global.high_scores[level_name[global.current_level]]:
		global.high_scores[level_name[global.current_level]] = score
		global.save_scores()
		
	global.current_score = score
	
	print("Showing level score...")
	var level_score_screen = "res://scenes/level_scores/" + str(global.current_level) + "_" + level_name[global.current_level] + ".tscn"
	get_tree().change_scene(level_score_screen)
