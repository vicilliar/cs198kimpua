
extends Area2D
signal key_clicked
const settings = preload("res://scripts/settings.gd")




func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			emit_signal("key_clicked")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
