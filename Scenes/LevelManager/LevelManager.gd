extends Node

const yellowIndex=0
const blueIndex=1
const redIndex=2
var level1Conf=[]
var allLevelConf=[]
var currentLevel=1

func _ready():
	allLevelConf.insert(0,[[Vector2(1,2),Vector2(3,4)],[Vector2(4,4)],[Vector2(5,4)]])

func getYellows(forThisLevel):
	return allLevelConf[forThisLevel-1][yellowIndex]

func getBlues(forThisLevel):
	return allLevelConf[forThisLevel-1][blueIndex]

func getReds(forThisLevel):
	return allLevelConf[forThisLevel-1][redIndex]