extends Node2D

var yellowBrick=preload("res://Scenes/Bricks/BrickBase/BrickBase.tscn")
var positionArray
const widthNumber=20
const heightNumber=7
func _ready():
	positionArray=create_2d_array(widthNumber,heightNumber,0)
	positionArray[2][3]=1
	addBrick(Vector2(2,3),GlobalValues.brickColor.Yellow)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func addBrick(position,color):
	var Instance=yellowBrick.instance()
	Instance.setBodyColor(color)
	Instance.setPosition(Vector2(position.x,position.y))
	Instance.position=$GridAreaRoot._gridToLocalCoordinate(Instance.getPosition())+$GridAreaRoot.position
	Instance.enemyColor =color
	Instance.connect("this_brick_gone",self,"_that_brick_gone")
	self.add_child(Instance)
	
func _that_brick_gone(position,color):
	if color == GlobalValues.brickColor.Red:
		positionArray[position.x][position.y]=0
	var Instance_x=round(rand_range(position.x-1,position.x+1))
	var Instance_y=round(rand_range(position.y-1,position.y+1))
	if positionArray[Instance_x][Instance_y] == 0 :
		addBrick(Vector2(Instance_x,Instance_y),GlobalValues.brickColor.Yellow)
		positionArray[Instance_x][Instance_y] =1
	else:
		print(Vector2(Instance_x,Instance_y))
	if color == GlobalValues.brickColor.Yellow : 
		addBrick(position,GlobalValues.brickColor.Blue)
	if color == GlobalValues.brickColor.Blue : 
		addBrick(position,GlobalValues.brickColor.Red)

func create_2d_array(width, height, value):
    var a = []
    for y in range(height):
        a.append([])
        a[y].resize(width)

        for x in range(width):
            a[y][x] = value
    return a