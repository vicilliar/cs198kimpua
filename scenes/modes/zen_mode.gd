extends Node2D

# TODO: Make sure header covers key buttons! It needs to CONSUME the event or something, before the key can.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_reskin(interval):
	print("Interval check: ", interval)
	get_node("zen_mode_header").reskin_header(interval)
	for x in self.get_children():
		print(x.name)
