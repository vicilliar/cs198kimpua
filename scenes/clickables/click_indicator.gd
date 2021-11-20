extends Node2D
var interval_state
var to_destroy

# Called when the node enters the scene tree for the first time.
func _ready():
	to_destroy = false


func final_animation(anim):
	$AnimatedSprite.set_animation(str(interval_state) + "_" + anim)
	$AnimatedSprite.play()
	to_destroy = true


func _on_AnimatedSprite_animation_finished():
	# indicator gets deleted after final animation
	if to_destroy:
		self.queue_free()
