extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var anim = ""
var has_sword = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if has_sword:
		anim="_ws"
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if velocity.x > 0:
		animated_sprite.flip_h = false	
	elif velocity.x < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle"+anim)
		else:
			animated_sprite.play("run"+anim)
	else:
		animated_sprite.play("jump"+anim)	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func hit(hitDirection,delta):
	animated_sprite.play("hit")
	velocity.x += hitDirection * 90
func pickupSword():
	has_sword = true