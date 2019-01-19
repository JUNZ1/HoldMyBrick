extends Node2D
onready var gridControlAreaNode=get_node("GridColorArea")
func _gridToLocalCoordinate(gridCoordinate):
	var globalCoord= Vector2(((gridCoordinate.x)*gridControlAreaNode.cellsize),((gridCoordinate.y)*gridControlAreaNode.cellsize))
	return globalCoord


func _ready():
	pass


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
