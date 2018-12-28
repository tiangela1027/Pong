extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (int) var speed

var velocity
var paddle_y

signal enemy_hit


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	paddle_y = $shape.polygon[2].y - $shape.polygon[1].y

	
func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed('enemy_right'):
		velocity.x += 1
	if Input.is_action_pressed('enemy_left'):
		velocity.x -= 1
	if Input.is_action_pressed('enemy_up'):
		velocity.y -= 1
	if Input.is_action_pressed('enemy_down'):
		velocity.y += 1
		
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		if collision_info.collider.is_in_group("ball"):
			emit_signal("enemy_hit")