extends CharacterBody2D


const SPEED = 300.0
const SPEED_CHANGE = 30
const JUMP_VELOCITY = -400.0
const LOAD_TIMER = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var load_timer = -1

func _physics_process(delta):
	if not is_on_floor() and load_timer < 0:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if load_timer > 0:
		load_timer -= delta

	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif load_timer < 0:
			load_timer = LOAD_TIMER
		else:
			load_timer = -1

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED_CHANGE)
		$sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_CHANGE)
	
	if load_timer > 0:
		$sprite.play("loading")
	else:
		if abs(velocity.y) > 0.1:
			$sprite.play("jump")
		else:
			if abs(velocity.x) > 0:
				if abs(direction) > 0 and sign(direction) != sign(velocity.x):
					$sprite.play("turn")
				else:
					$sprite.play("run")
			else:
				$sprite.play("idle")

	move_and_slide()
