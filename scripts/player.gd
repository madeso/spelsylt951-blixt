extends CharacterBody2D


const SPEED = 300.0
const SPEED_CHANGE = 30
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# if not is_on_floor():
	#	velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED_CHANGE)
		$sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_CHANGE)
	
	if abs(velocity.x) > 0:
		if abs(direction) > 0 and sign(direction) != sign(velocity.x):
			$sprite.play("turn")
		else:
			$sprite.play("run")
	else:
		$sprite.play("idle")

	move_and_slide()