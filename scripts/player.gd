extends CharacterBody2D


const SPEED = 100.0
var current_direction = "none"

func _ready():
	# this function makes it do the front idle animation when you first run the game
	$CollisionShape2D/AnimatedSprite2D.play("front_idle") 

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
		
	elif Input.is_action_just_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.y = SPEED
		velocity.x = 0
		
		
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
			
	move_and_slide()
	
	

func play_animation(movement):
	var dir = current_direction
	var animation = $CollisionShape2D/AnimatedSprite2D	
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
		
	if dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
			
	if dir == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			animation.play("back_idle")
			
	if dir == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			animation.play("front_idle")
	
	
