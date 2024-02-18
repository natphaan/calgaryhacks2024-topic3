extends CharacterBody2D

const speed = 100
var current_dir = "none"
var enemy_range_attack = false
var enemy_attack_cooldown = true
var health = 200
var player_status = true
var attack_in_progess = false


func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	if health <= 0:
		player_status = false
		health = 0
		print("player died")
		self.queue_free() # to despawn the player because it lost all of its health
	
func _ready():
	$AnimatedSprite2D.play("front_idle")

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_animation(movement):
	var dir= current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_in_progess == false:
				anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_in_progess == false:
				anim.play("side_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_in_progess == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_in_progess == false:
				anim.play("back_idle")
			

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("slime"):
		enemy_range_attack = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("slime"):
		enemy_range_attack = false
		
		
func enemy_attack():
	if enemy_range_attack and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_in_progess = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
			
		if dir == "left":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
			
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
			
			
			
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_in_progess = false
