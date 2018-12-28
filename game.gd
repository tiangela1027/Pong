extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var midline
var paddle_y
var player_counter
var enemy_counter

signal player_hit
signal enemy_hit

var clicked

func _ready():
	player_counter = 0
	enemy_counter = 0
	
	clicked = false
	
	midline = get_viewport_rect().size.y / 2
	paddle_y = ($paddle/shape.polygon[2].y - $paddle/shape.polygon[1].y) * $paddle/shape.scale.y
	
	$paddle.position = Vector2($paddle.position.x, midline - paddle_y / 2)
	$enemy.position = Vector2($enemy.position.x, midline + paddle_y / 2)
	
	which_side()
	
func start():
	clicked = false
	
	$paddle.position = Vector2($paddle.position.x, midline - paddle_y / 2)
	$enemy.position = Vector2($enemy.position.x, midline + paddle_y / 2)
	
	which_side()
	
	get_tree().paused = false


func _on_goal_body_entered(body):
	player_counter = player_counter + 1
	$counter/player_count.text = str(player_counter)
	$goal/hit.show()
	get_tree().paused = true
	clicked = true
	get_input()
	emit_signal("player_hit")


func _on_goal_enemy_body_entered(body):
	enemy_counter = enemy_counter + 1
	$counter/enemy_count.text = str(enemy_counter)
	$goal_enemy/hit.show()
	get_tree().paused = true
	clicked = true
	get_input()
	emit_signal("enemy_hit")
	
func get_input():
	if clicked:
		if Input.is_action_just_pressed("click"):
			print("hallelujah")
			start()
		

func which_side():
	if player_counter <= enemy_counter:
		$ball.position = Vector2(get_viewport_rect().size.x / 2 - 30, get_viewport_rect().size.y / 2)
	else:
		$ball.position = Vector2(get_viewport_rect().size.x / 2 + 30, get_viewport_rect().size.y / 2)

func _on_paddle_paddle_hit():
	$ball.velocity = Vector2(-$ball.speed, 0)


func _on_enemy_enemy_hit():
	$ball.velocity = Vector2($ball.speed, 0)
