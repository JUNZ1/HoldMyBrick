extends RigidBody2D
const maxSpeed = 500
func _ready():
	$Area2D.connect("area_entered",self,"_onAreaEntered")

func _process(delta):
	if linear_velocity.x< -maxSpeed:
		linear_velocity.x= -maxSpeed

	if linear_velocity.x> maxSpeed:
		linear_velocity.x= maxSpeed

	if linear_velocity.y< -maxSpeed:
		linear_velocity.y= -maxSpeed

	if linear_velocity.y< -maxSpeed:
		linear_velocity.y= -maxSpeed
func _onAreaEntered(area):
	if area.get_parent().is_in_group("Player"):
		linear_velocity.x=linear_velocity.x*1.5
		linear_velocity.y=linear_velocity.y*1.5