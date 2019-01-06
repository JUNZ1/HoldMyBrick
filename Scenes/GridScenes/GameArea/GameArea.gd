extends Node2D

var yellowBrick=preload("res://Scenes/Bricks/YellowBrick/YellowBrickRoot.tscn")

func _ready():
	var yellowInstance=yellowBrick.instance()
	yellowInstance.rect_position=$GridAreaRoot._gridToLocalCoordinate(Vector2(2,2))+$GridAreaRoot.position
	self.add_child(yellowInstance)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
