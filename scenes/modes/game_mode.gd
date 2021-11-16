extends Node2D

var score
var notes_to_play
# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_reskin(interval):
	print("Interval check: ", interval)
	get_node("game_mode_header").reskin_header(interval, "game_mode")
	for x in self.get_children():
		print(x.name)

func on_home_pressed():
	get_tree().change_scene("res://scenes/home.tscn")

# main_timer decides when to spawn REQURED NOTES (includes: visual indicator, note timer, ?)
# if note timer times out, FAILED. indicator disappears and no points
# Code the timing, so that when note needs to be spawned, it times out main_timer!

# keyboard will emit signals to game_mode when each key is pressed. calculations will be done after receiving.
# if pressed note in list of notes to be pressed:
	# if pressed within proper window (based on timer), give proper points (what if needs to be held??)
	# else, FAILED
