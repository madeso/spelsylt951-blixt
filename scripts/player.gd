extends CharacterBody2D


const SPEED = 300.0
const SPEED_CHANGE = 30
const JUMP_VELOCITY = -400.0
const LOAD_TIMER = 1
const DASH_TIME = 5
const DASH_SPEED = 1600

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var load_timer = -1
var dash_dir = 0

func _physics_process(delta):
	if not is_on_floor() and load_timer < 0:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if load_timer > 0:
		load_timer -= delta

	if Input.is_action_just_pressed("ui_accept"):
		if load_timer > 0:
			load_timer = -1
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			load_timer = LOAD_TIMER
			dash_dir = 0
			velocity.x - 0
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if load_timer > 0:
		if dash_dir == 0:
			if Input.is_action_just_pressed("ui_left"):
				dash_dir = 4
				load_timer = DASH_TIME
				$sprite.flip_h = true
			elif Input.is_action_just_pressed("ui_right"):
				dash_dir = 6
				load_timer = DASH_TIME
				$sprite.flip_h = false
			elif Input.is_action_just_pressed("ui_down"):
				dash_dir = 2
				load_timer = DASH_TIME
			elif Input.is_action_just_pressed("ui_up"):
				dash_dir = 8
				load_timer = DASH_TIME
		else:
			velocity.x = 0
			velocity.y - 0
			if dash_dir == 4:
				velocity.x = -DASH_SPEED
			elif dash_dir == 6:
				velocity.x = DASH_SPEED
			elif dash_dir == 8:
				velocity.y = -DASH_SPEED
			elif dash_dir == 2:
				velocity.y = DASH_SPEED
	else:
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, SPEED_CHANGE)
			$sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED_CHANGE)
	
	if load_timer > 0:
		if dash_dir == 0:
			$sprite.play("loading")
		else:
			$sprite.play("dash")
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

	var collided = move_and_slide()
	if collided and dash_dir != 0:
		var reset = false
		
		if dash_dir == 4 and is_on_wall_only():
			reset = true
		if dash_dir == 6 and is_on_wall_only():
			reset = true
		if dash_dir == 8 and is_on_ceiling_only():
			reset = true
		if dash_dir == 2 and is_on_floor_only():
			reset = true
		if reset:
			dash_dir = 0
			velocity.x = 0
			velocity.y = 0
			load_timer = LOAD_TIMER
