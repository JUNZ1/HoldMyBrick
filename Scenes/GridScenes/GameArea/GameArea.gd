extends Node2D
var loadingScreen = preload("res://Scenes/LoadingScreen/LoadingScene.tscn")
var yellowBrick=preload("res://Scenes/Bricks/BrickBase/BrickBase.tscn")
var brickBase=preload("res://Scenes/Bricks/BrickBase/BrickBase.tscn")
var blueBrick= preload("res://Scenes/Bricks/BlueBrick/BlueBrickRoot.tscn")
var greenBrick=preload("res://Scenes/Bricks/GreenBrick/GreenBrickRoot.tscn")
var orangeBrick=preload("res://Scenes/Bricks/OrangeBrick/OrangeBrickRoot.tscn")
var purpleBrick=preload("res://Scenes/Bricks/PurpleBrick/PurpleBrickRoot.tscn")
var redBrick=preload("res://Scenes/Bricks/RedBrick/RedBrickRoot.tscn")
var tealBrick=preload("res://Scenes/Bricks/TealBrick/TealBrickRoot.tscn")

var positionArray
onready var PlayerNode=get_node("Player")
const widthNumber=20
const heightNumber=7
var neighBourSeek =0
var spawnedBrickList=[]
func _ready():
	positionArray=create_2d_array(widthNumber,heightNumber,0)
	adjustLevel()
	$BrickSpawnTimer.connect("timeout",self,"_tickTock")

func adjustLevel():
	for yellows in LevelManager.getGreens(LevelManager.currentLevel):
		addBrick(yellows,GlobalValues.brickColor.Green)
	
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
	for a in range(-1,2):
		for b in range (-1,2):
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
	var insertThisToList=[position,color]
	spawnedBrickList.push_back(insertThisToList)


func etrafSarili(komsuArray):
	var toplam=0
	for eachPosition in komsuArray:
		toplam=toplam+positionArray[eachPosition.y][eachPosition.x]
	return toplam

func _that_brick_gone(position,color):
	if color == GlobalValues.brickColor.Red:
		positionArray[position.y][position.x]=0
	var allNeigbours=getNeighbours(position)
	while allNeigbours.size() >0:
		var randIndex=randi()%(allNeigbours.size())
#		print("Size: ",allNeigbours.size())
#		print("Rand Index: ",randIndex)
#		print(allNeigbours)
		if positionArray[allNeigbours[randIndex].y][allNeigbours[randIndex].x] ==0:
			addBrick(allNeigbours[randIndex],GlobalValues.brickColor.Green)
			break
		else:
			allNeigbours.remove(randIndex)
			print("Kalan Size: ",allNeigbours.size())
			print("RandIndex: ", randIndex)
			print(allNeigbours)
	if color == GlobalValues.brickColor.Green : 
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

func _tickTock():
	if spawnedBrickList.size()==0:
		return
	var poppedOne=spawnedBrickList.pop_front()
	var position = poppedOne[0]
	var color = poppedOne[1]
	positionArray[position.y][position.x]=1
	var Instance=brickBase.instance()
	Instance.setBodyColor(color)
	Instance.setPosition(Vector2(position.x,position.y))
	Instance.position=$GridAreaRoot._gridToLocalCoordinate(Instance.getPosition())+$GridAreaRoot.position
	Instance.enemyColor =color
	Instance.connect("this_brick_gone",self,"_that_brick_gone")
	var colorInstance
	if color == GlobalValues.brickColor.Blue:
		colorInstance= blueBrick.instance()

	if color == GlobalValues.brickColor.Red:
		colorInstance= redBrick.instance()
	if color == GlobalValues.brickColor.Green:
		colorInstance= greenBrick.instance()
	if color == GlobalValues.brickColor.Blue:
		colorInstance= blueBrick.instance()
	if color == GlobalValues.brickColor.Yellow:
		colorInstance= yellowBrick.instance()
	if color == GlobalValues.brickColor.Orange:
		colorInstance= orangeBrick.instance()
	if color == GlobalValues.brickColor.Purple:
		colorInstance= purpleBrick.instance()
	if color == GlobalValues.brickColor.Teal:
		colorInstance= tealBrick.instance()

	Instance.add_child(colorInstance)
	self.add_child(Instance)