extends Node2D
var loadingScreen = preload("res://Scenes/LoadingScreen/LoadingScene.tscn")
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

func getNeighbours(position):
	var neigbourList=[]
	for a in range(-2,3):
		for b in range (-2,3):
			var newPoint=position
			newPoint.x=position.x+a
			newPoint.y=position.y+b
			if newPoint.y >= heightNumber or newPoint.y <0:
				continue
			if newPoint.x >= widthNumber or newPoint.x < 0:
				continue
			if newPoint == position:
				continue
			neigbourList.push_back(newPoint)
	return neigbourList


func addBrick(position,color):
	positionArray[position.y][position.x]=1
	var Instance=yellowBrick.instance()
	Instance.setBodyColor(color)
	Instance.setPosition(Vector2(position.x,position.y))
	Instance.position=$GridAreaRoot._gridToLocalCoordinate(Instance.getPosition())+$GridAreaRoot.position
	Instance.enemyColor =color
	Instance.connect("this_brick_gone",self,"_that_brick_gone")
	self.add_child(Instance)

func etrafSarili(komsuArray):
	var toplam=0
	for eachPosition in komsuArray:
		toplam=toplam+positionArray[eachPosition.y][eachPosition.x]
	return toplam

func _that_brick_gone(position,color):
	if color == GlobalValues.brickColor.Red:
		positionArray[position.y][position.x]=0
	var allNeigbours=getNeighbours(position)
	if etrafSarili(allNeigbours) >=7:
		print(etrafSarili(allNeigbours))
		return
	var checkedIndexArray=[]
	while allNeigbours.size() >=1:
		var randIndex=randi()%(allNeigbours.size()-1)+1
		if positionArray[allNeigbours[randIndex].y][allNeigbours[randIndex].x] ==0:
			addBrick(allNeigbours[randIndex],GlobalValues.brickColor.Yellow)
			if color == GlobalValues.brickColor.Yellow : 
				addBrick(position,GlobalValues.brickColor.Blue)
			if color == GlobalValues.brickColor.Blue : 
				addBrick(position,GlobalValues.brickColor.Red)
			return
		else:
			allNeigbours.erase(randIndex)


func create_2d_array(width, height, value):
    var a = []
    for y in range(height):
        a.append([])
        a[y].resize(width)
        for x in range(width):
            a[y][x] = value
    return a