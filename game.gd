extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var midline
var paddle_y
var player_counter
var enemy_counter

var side # side that won goal; 0 for player, 1 for enemy

signal player_goal
signal enemy_goal
signal paused

func _ready():
	player_counter = 0
	enemy_counter = 0
	
	side = 1
	
	midline = get_viewport_rect().size.y / 2
	paddle_y = ($paddle/shape.polygon[2].y - $paddle/shape.polygon[1].y) * $paddle/shape.scale.y
	
	$paddle.position = Vector2($paddle.position.x, midline - paddle_y / 2)
	$enemy.position = Vector2($enemy.position.x, midline - paddle_y / 2)
	
	
func start():
	which_side()


func _on_goal_body_entered(body):
	$hit.play()
	player_counter = player_counter + 1
	emit_signal("enemy_goal")
	emit_signal("paused")
	$counter/player_count.text = str(player_counter)
	side = 0


func _on_goal_enemy_body_entered(body):
	$hit.play()
	enemy_counter = enemy_counter + 1
	emit_signal("player_goal")
	emit_signal("paused")
	$counter/enemy_count.text = str(enemy_counter)
	side = 1
		

func which_side():
	$ball.velocity = Vector2(0, 0)
	
	if side == 1:
		$ball.position = Vector2(get_viewport_rect().size.x / 2 - 90, get_viewport_rect().size.y / 2)
	elif side == 0:
		$ball.position = Vector2(get_viewport_rect().size.x / 2 + 90, get_viewport_rect().size.y / 2)


func _on_paddle_paddle_hit():
	$ball.velocity = Vector2(-$ball.speed, 0)


func _on_enemy_enemy_hit():
	$ball.velocity = Vector2($ball.speed, 0)


func _on_hit_finished():
	$ball.hide()

