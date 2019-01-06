extends Node2D

var gridPosition = Vector2()
signal this_brick_gone(position)
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print(gridPosition)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
