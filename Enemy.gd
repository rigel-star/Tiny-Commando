extends KinematicBody2D

const Gravity = 10
const Speed = 40
const FLOOR = Vector2(0, -1)

var Velocity = Vector2()
var direction = 1
var is_dead = false

func dead():
	is_dead = true
	Velocity = Vector2(0, 0)
	$AnimatedSprite.play("Die")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _physics_process(delta):
	if is_dead == false:
		Velocity.x = Speed * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
			
		$AnimatedSprite.play("Walk")
		Velocity.y += Gravity
		Velocity = move_and_slide(Velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
func _on_Timer_timeout():
	queue_free()
