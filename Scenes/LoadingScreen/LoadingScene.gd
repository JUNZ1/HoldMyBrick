extends Node2D

var gameAreaNode=preload("res://Scenes/GridScenes/GameArea/GameArea.tscn")

func _ready():
	$Timer.connect("timeout",self,"_tickTock")

func _tickTock():
	print("Time is Up")
	get_tree().change_scene_to(gameAreaNode)