extends Node2D

var life = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var lifescale = $"../UICanvas/UI/lifebar/lifescale"
@onready var life_label = $"../UICanvas/UI/TileMap/Label"
@onready var player = $"../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_life() -> int :
	return life
	
func remove_life():
	life -= 1
	print(lifescale.scale.x)
	lifescale.scale.x = lifescale.scale.x - 0.7
	life_label.text = "Life: " + str(life) 
	if life == 0:
		player.play
		get_tree().reload_current_scene()
