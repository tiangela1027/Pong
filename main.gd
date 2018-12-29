extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player_counter
var enemy_counter
var win

signal done


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	player_counter = 0
	enemy_counter = 0
	win = 10


func _on_time_unpause():
	$game/ball.show()
	$game.start()


func _on_game_player_goal():
	player_counter = player_counter + 1
	if player_counter == win:
		$win/enemy.show()
		_on_game_won()


func _on_game_enemy_goal():
	enemy_counter = enemy_counter + 1
	if enemy_counter == win:
		$win/player.show()
		_on_game_won()


func _on_game_paused():
	$game/ball.hide()
	
	
func _on_game_won():
	emit_signal("done")
	get_tree().paused = true
