extends ColorRect

var cellsize=50

onready var gridSize =Vector2(self.get_size().x,self.get_size().y)
var circleCoordinates=[]

var yellowBrick=preload("res://Scenes/Bricks/YellowBrick/YellowBrickRoot.tscn")

func _ready():
	set_process_input(true)


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			if event.position.x > get_parent().position.x and event.position.x < gridSize.x + get_parent().position.x:
				if event.position.y> get_parent().position.y and event.position.y < gridSize.y + get_parent().position.y:
					var gridCoordinate= Vector2(int((get_local_mouse_position().x)/cellsize),int((get_local_mouse_position().y)/cellsize))
					print(gridCoordinate)
					_gridToLocalCoordinate(gridCoordinate)


func _process(delta):
	update()

func _draw():
	for x in range(0,gridSize.x,cellsize):
		for y in range(0,gridSize.y,cellsize):
			draw_line(Vector2(x,y),Vector2(x,y+cellsize),Color(0,1,0),1)
			draw_line(Vector2(x,y),Vector2(x+cellsize,y),Color(0,1,0),1)
	for i in range(circleCoordinates.size()):
		draw_circle(circleCoordinates[i],20,Color(0,0,1))


func _gridToLocalCoordinate(gridCoordinate):
	var globalCoord= Vector2(((gridCoordinate.x)*cellsize)+cellsize/2,((gridCoordinate.y)*cellsize)+cellsize/2)
	circleCoordinates.append(globalCoord)
	return globalCoord
