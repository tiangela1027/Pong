extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player_counter
var enemy_counter
var win
var done

signal done


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	player_counter = 0
	enemy_counter = 0
	win = 10
	done = false


func _on_time_unpause():
	$game/ball.show()
	$game.start()


func _on_game_player_goal():
	player_counter = player_counter + 1
	if player_counter == win:
		$time.queue_free()
		$win/enemy.show()
		$game/hit.play()
		done = true


func _on_game_enemy_goal():
	enemy_counter = enemy_counter + 1
	if enemy_counter == win:
		$time.queue_free()
		$win/player.show()
		$game/hit.play()
		done = true


func _on_game_paused():
	$game/ball.hide()
	
	
func _on_game_won():
	get_tree().paused = true
	
func _on_hit_finished():
	if done:
		_on_game_won()
