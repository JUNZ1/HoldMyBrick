extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var GameAreaNode=preload("res://Scenes/GridScenes/GameArea/GameArea.tscn")
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$TouchScreenButton.connect("pressed",self,"_playPressed")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _playPressed():
	get_tree().change_scene_to(GameAreaNode)