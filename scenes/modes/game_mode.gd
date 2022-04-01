extends Node2D

var score
var current_streak		# number of notes played correctly in succession
var current_combo_score	# current score to be added based on combo meter
var current_combo_multiplier
var highest_streak		# longest streak
var live_notes			# list of dictionaries representing live notes: name, click_indicator, & click_timer. start and end also included just in case!
var note_list			# list of dictionaries of level notes and their details
var last_spawn_time
var elapsed_time
var level_music_time	# bgm duration
var level_name = {1:"easy", 2:"medium", 3:"hard"}
var next_note_index
var current_interval_state = 1
var feedback_sound_correct
var exit_type = ""

export (PackedScene) var Click_Indicator
# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	play_level(global.current_level)
	get_node("game_mode_header").default_header("game_mode")
	feedback_sound_correct = get_node("feedback_correct")


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
	current_streak = 0
	highest_streak = 0
	current_combo_score = 100
	current_combo_multiplier = null
	
	update_scoreboard()
	
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
	$temp_score.set_bbcode("[center]" + str(score) + "[/center]")
	if (score != 0):
		$added_score.set_bbcode("[center][wave amp=80]+ " + str(current_combo_score) + "[/wave][/center]")
		$added_score_timer.start()
		
	if (current_streak > 0):
		$streak.set_bbcode("[right]" + str(current_streak) + "[/right]")
		
	if (current_combo_multiplier != null):
		$multiplier.set_bbcode("[right][shake rate=10 level=10] STREAK BONUS " + str(current_combo_multiplier) + "[/shake][/right]")
		
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
			get_node("keyboard").check_reskin(false)
			$text_feedback.final_animation("missed")

			# Check if current streak is the highest
			if current_streak > highest_streak:
				highest_streak = current_streak
			# Reset streak numbers
			current_streak = 0
			current_combo_score = 100
			current_combo_multiplier = null
			$streak.set_bbcode("[right]0[/right]")
			$multiplier.set_bbcode("")
			
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
				get_node("keyboard").check_reskin(true)
				
				# Update streak numbers
				current_streak += 1
				if current_streak in Consts.combo_meter:
					current_combo_score = Consts.combo_meter[current_streak]['points']
					current_combo_multiplier = Consts.combo_meter[current_streak]['multiplier']
				
				score += current_combo_score
				
				print("Current Combo Score: " + str(current_combo_score))
				print("Current Streak: " + str(current_streak))
				
				update_scoreboard()
				despawn_live_note(note, "correct")
				
				feedback_sound_correct.play()
				if note["click_timer"].get_time_left() <= 0.5:
					$text_feedback.final_animation("perfect")
				else:
					$text_feedback.final_animation("great")
				return
			else:
				# Wrong: WRONG TIMING (kill all notes)
				print("Wrong! Wrongly timed press.")
				get_node("keyboard").check_reskin(false)
				$text_feedback.final_animation("early")
				
				# Check if current streak is the highest
				if current_streak > highest_streak:
					highest_streak = current_streak
				# Reset streak numbers
				current_streak = 0
				current_combo_score = 100
				current_combo_multiplier = null
				$streak.set_bbcode("[right]0[/right]")
				$multiplier.set_bbcode("")

				for note_to_despawn in live_notes:
					despawn_live_note(note_to_despawn, "wrong")
				return

	# Wrong: WRONG NOTE PLAYED (kill all notes)
	print("Wrong! Wrong note played.")
	get_node("keyboard").check_reskin(false)
	$text_feedback.final_animation("oops")
	
	# Check if current streak is the highest
	if current_streak > highest_streak:
		highest_streak = current_streak
	# Reset streak numbers
	current_streak = 0
	current_combo_score = 100
	current_combo_multiplier = null
	$streak.set_bbcode("[right]0[/right]")
	$multiplier.set_bbcode("")

	for note_to_despawn in live_notes:
		despawn_live_note(note_to_despawn, "wrong")
	
func _on_level_music_timer_timeout():
	$level_music_timer.stop()
	
	if current_streak > highest_streak:
		highest_streak = current_streak
	
	if score > global.high_scores[level_name[global.current_level]]:
		global.high_scores[level_name[global.current_level]] = score
		global.save_scores()
		
	global.current_score = score
	global.current_highest_streak = highest_streak
	
	print("Showing level score...")
	var level_score_screen = "res://scenes/level_scores/" + str(global.current_level) + "_" + level_name[global.current_level] + ".tscn"
	get_tree().change_scene(level_score_screen)


func _on_button_home_pressed():
	get_tree().get_root().get_node("persistent/sfx_pause_button").play()
	get_node("confirm_action").show()
	get_tree().set_deferred("paused", true)
	
func _on_cancel_end_game():
	get_node("confirm_action").hide()
	get_tree().set_deferred("paused", false)

func _on_confirm_end_game():
	get_node("confirm_action").hide()
	get_tree().set_deferred("paused", false)
	get_tree().change_scene("res://scenes/home.tscn")

func _on_button_settings_pressed():
	get_tree().get_root().get_node("persistent/sfx_pause_button").play()
	get_node("settings_screen").show()
	get_tree().set_deferred("paused", true)

func _on_settings_screen_resume():
	get_node("settings_screen").hide()
	get_tree().set_deferred("paused", false)

func _on_settings_screen_end_game():
	get_tree().set_deferred("paused", false)
	_on_level_music_timer_timeout()





	
