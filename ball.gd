extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (int) var speed

var velocity = Vector2()
var paddle_y

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	paddle_y = 16.72 * 7 / 2

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		var paddle = collision_info.collider
		var paddle_pos = paddle.position
		
		if abs(collision_info.position.y - paddle_pos.y - paddle_y) <= 35:
			velocity = velocity.bounce(collision_info.normal)
		elif collision_info.position.y - paddle_pos.y - paddle_y < 0:
			velocity = velocity.bounce(collision_info.normal).rotated(75)
		else:
			velocity = velocity.bounce(collision_info.normal).rotated(-75)
