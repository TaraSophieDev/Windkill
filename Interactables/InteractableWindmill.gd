extends Interactable

export var windblade : NodePath
export var on_by_default = false

onready var windblade_node = get_node(windblade)
onready var on = on_by_default

func _process(delta):
	set_windblade_rotation_speed(delta)

func get_interaction_text():
	return "turn on" if !on else ""
	
func interact():
	on = true

func set_windblade_rotation_speed(delta):
	if on:
		windblade_node.rotate(Vector3(0, 0, 1), delta)
