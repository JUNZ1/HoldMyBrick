extends KinematicBody2D
export var speed: int = 750
var velocity = Vector2(0,1)

func _init():
	self.connect("visibility_changed",self,"_onVisibility_changed")

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * speed)
	if collision:
		velocity = velocity.bounce(collision.normal)