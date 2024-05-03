extends Area2D

@onready var collision_shape = $CollisionShape2D

func _on_body_entered(body):
	if body.has_method("pickupSword"):
		body.pickupSword()
	queue_free()
