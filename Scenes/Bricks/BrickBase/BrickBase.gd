extends Node2D

signal this_brick_gone(position,color)
var gridCoordinate=Vector2()

var enemyColor = GlobalValues.brickColor.Yellow
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	setBodyColor(enemyColor)
	$Area2D.connect("area_entered",self,"_areaEntered")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func setBodyColor(color):
	pass

func setPosition(position):
	gridCoordinate=position

func getPosition():
	return gridCoordinate
	
func _areaEntered(area):
	emit_signal("this_brick_gone",gridCoordinate,enemyColor)
	self.queue_free()