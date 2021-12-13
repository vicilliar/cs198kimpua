extends Node2D

var to_remove

# Called when the node enters the scene tree for the first time.
func _ready():
	to_remove = false
	$feedback.hide()

func final_animation(anim):
	$feedback.show()
	$feedback.set_animation(anim)
	$feedback.play()
	to_remove = true


func _on_feedback_animation_finished():
	if to_remove:
		$feedback.stop()
		$feedback.hide()
