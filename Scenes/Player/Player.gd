extends ColorRect

export var MOVE_SPEED = 400
func _ready():
	pass

func _process(delta):
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
	rect_position += (delta * MOVE_SPEED) * input_dir