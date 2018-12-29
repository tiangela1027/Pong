extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var count_down

signal unpause

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	count_down = false

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if count_down:
		$label.text = str(int($label/countdown.time_left) + 1)


func _on_game_paused():
	$label/countdown.start()
	count_down = true
	$label.show()


func _on_countdown_timeout():
	$label.hide()
	count_down = false
	emit_signal("unpause")


func _on_main_done():
	queue_free()
