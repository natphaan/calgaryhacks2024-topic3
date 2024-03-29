extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position/speed)
	
func _on_detection_area_body_exited(body):
	player_chase = null
	player_chase = false

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
