extends Node2D

var to_remove

# Called when the node enters the scene tree for the first time.
func _ready():
	to_remove = false
	$interval.hide()

func final_animation(anim):
	$interval.show()
	$interval.set_animation(str(anim))
	$interval.play()
	to_remove = true


func _on_feedback_animation_finished():
	if to_remove:
		$interval.stop()
		$interval.hide()
