extends Node2D

const SPEED = 60

var direction = 1

@onready var attack_detection = $attack_detection
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_front = $attack_front
@onready var look_left = $look_left
@onready var look_right = $look_right

var pause = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check if on ground and going back if not
	if !look_left.is_colliding():
		direction = 1
	if !look_right.is_colliding():
		direction = -1
	
	# check if player enter the raycast and get ready to attack	with anim and stop moving
	if attack_detection.is_colliding():
		animated_sprite.play("attack_ready")
		pause = 0
	else:
		animated_sprite.play("idle")
		pause = 1
	#attack the target
	if attack_front.is_colliding():
		animated_sprite.play("attack")
		var coll = attack_front.get_collider()
		if coll.has_method("hit"):
			coll.hit(direction)
	# change direction of the sprite and raycast
	if direction == 1:
		animated_sprite.flip_h =  true
		attack_detection.rotation_degrees = 180
		attack_front.rotation_degrees = 180
	else:
		animated_sprite.flip_h =  false
		attack_detection.rotation_degrees = 0
		attack_front.rotation_degrees = 0

	position.x += direction *  SPEED * delta * pause
