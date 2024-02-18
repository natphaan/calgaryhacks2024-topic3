extends CharacterBody2D

var speed = 200
var player_chase = false
var player = null
var health = 100
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):
	if player_chase:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
