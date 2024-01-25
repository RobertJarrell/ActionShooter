class_name  FiringComponent

extends Node

@export var bullet_spawn : SpawnerComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire(muzzle : Node3D):
	print("firing")
	bullet_spawn.spawn(muzzle.global_position)
	
