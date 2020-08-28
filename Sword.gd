extends Area2D

const Speed = 400
const Velocity = Vector2()
var direction = 1

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
	
func _physics_process(delta):
	Velocity.x = Speed * delta
	translate(Velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Sword_body_entered(body):
	if "Enemy" in body.name:
		body.dead()
	queue_free()
