extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const DASH = 3000
var CAN_DASH : bool = false
var PLAY_BG_MUSIC : int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if is_on_floor():
		CAN_DASH = true
		PLAY_BG_MUSIC += 1
	if PLAY_BG_MUSIC == 1:
		#$BackgroundMusic.play()
		pass
	var direction = Input.get_axis("Left", "Right")
	if PLAY_BG_MUSIC == 0:
		direction = 0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity - 200) * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Jump") and is_on_wall():
		$Jump.play()
		velocity.y = JUMP_VELOCITY - 150

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		if Input.is_action_just_pressed("Dash") and not is_on_floor() and not is_on_wall() and direction and CAN_DASH:
			$Dash.play()
			velocity.x = direction * DASH
			CAN_DASH = false
		elif direction > 0:
			$AnimatedSprite2D.flip_h = false
			velocity.x = direction * SPEED
		elif direction < 0:
			$AnimatedSprite2D.flip_h = true
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
