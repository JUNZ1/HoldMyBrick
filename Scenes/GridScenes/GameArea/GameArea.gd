extends Node2D

var yellowBrick=preload("res://Scenes/Bricks/BrickBase/BrickBase.tscn")
var positionArray
onready var PlayerNode=get_node("Player")
const widthNumber=20
const heightNumber=7
var neighBourSeek =0

func _ready():
	positionArray=create_2d_array(widthNumber,heightNumber,0)
	adjustLevel()

func adjustLevel():
	for yellows in LevelManager.getYellows(LevelManager.currentLevel):
		addBrick(yellows,GlobalValues.brickColor.Yellow)
	
	for blues in LevelManager.getBlues(LevelManager.currentLevel):
		addBrick(blues,GlobalValues.brickColor.Blue)
	
	for reds in LevelManager.getReds(LevelManager.currentLevel):
		addBrick(reds,GlobalValues.brickColor.Red)

func _process(delta):
	if $Left_Button.pressed:
		PlayerNode.goLeft()
	if $Right_Button.pressed:
		PlayerNode.goRight()

func addBrick(position,color):
	positionArray[position.y][position.x]=1
	var Instance=yellowBrick.instance()
	Instance.setBodyColor(color)
	Instance.setPosition(Vector2(position.x,position.y))
	Instance.position=$GridAreaRoot._gridToLocalCoordinate(Instance.getPosition())+$GridAreaRoot.position
	Instance.enemyColor =color
	Instance.connect("this_brick_gone",self,"_that_brick_gone")
	self.add_child(Instance)
	
func _that_brick_gone(position,color):
	if color == GlobalValues.brickColor.Red:
		positionArray[position.y][position.x]=0
	var Instance_x=round(rand_range(position.x-1,position.x+1))
	var Instance_y=round(rand_range(position.y-1,position.y+1))
	if Instance_y >= heightNumber:
		Instance_y = heightNumber-1
	if Instance_x >= widthNumber:
		Instance_x = widthNumber-1
	if Instance_x < 0:
		Instance_x = 0
	if positionArray[Instance_y][Instance_x] == 0 :
		neighBourSeek=0
		addBrick(Vector2(Instance_x,Instance_y),GlobalValues.brickColor.Yellow)
		positionArray[Instance_y][Instance_x] =1
		if color == GlobalValues.brickColor.Yellow : 
			addBrick(position,GlobalValues.brickColor.Blue)
		if color == GlobalValues.brickColor.Blue : 
			addBrick(position,GlobalValues.brickColor.Red)
	else:
		_that_brick_gone(position,color)
		neighBourSeek=neighBourSeek+1
		if neighBourSeek == 7:
			get_tree().set_pause(true)


func create_2d_array(width, height, value):
    var a = []
    for y in range(height):
        a.append([])
        a[y].resize(width)

        for x in range(width):
            a[y][x] = value
    return a