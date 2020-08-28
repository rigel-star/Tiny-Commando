extends KinematicBody2D

const UP = Vector2(0, -1)
const Max_Speed = 130
const Accleration = 50
const Gravity = 20
const Jump_Height = -400
const Fireball = preload("res://Sword.tscn")

var motion = Vector2()
var is_attacking = false

func _physics_process(delta):
	motion.y += Gravity
	var Friction = false
	
	if Input.is_action_pressed("ui_right"):
		if is_attacking == false:
			motion.x = min(motion.x+Accleration, Max_Speed)
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			motion.x = max(motion.x-Accleration, -Max_Speed)
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("Run")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
			
	else:
		$AnimatedSprite.play("Idle")
		Friction = true
	
	if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
		is_attacking = true
		$AnimatedSprite.play("Attack")
		var fireball = Fireball.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = Jump_Height
		if Friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
			
	else:
		if motion.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
		if Friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
			
	motion = move_and_slide(motion, UP)

func _on_AnimatedSprite_animation_finished():
	is_attacking = false
