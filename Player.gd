extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 2
const GRAVITY = 10

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if not $AnimatedSprite.flip_h and input_vector.x < 0:
		$AnimatedSprite.flip_h = true
	elif $AnimatedSprite.flip_h and input_vector.x > 0:
		$AnimatedSprite.flip_h = false
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector
		$AnimatedSprite.play("run")
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite.play("idle")
		if $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.stop()
	
	velocity.x *= SPEED
	velocity.y += GRAVITY * delta
	move_and_collide(velocity)
