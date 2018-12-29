extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (int) var speed

var velocity = Vector2()
var paddle_y
var midline_x


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	paddle_y = 16.72 * 7 / 2
	midline_x = get_viewport_rect().size.x / 2


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		var paddle = collision_info.collider
		var paddle_pos = paddle.position
		
		if abs(collision_info.position.y - paddle_pos.y - paddle_y) <= 15:
			velocity = velocity.bounce(collision_info.normal)
		elif collision_info.position.y - paddle_pos.y - paddle_y < 0:
			velocity = velocity.bounce(collision_info.normal).rotated(75)
		else:
			velocity = velocity.bounce(collision_info.normal).rotated(-75)
