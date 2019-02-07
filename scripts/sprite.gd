extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _draw():
	var pos = $center.position
	draw_circle(pos, 24.5, Color(255, 255, 255))
