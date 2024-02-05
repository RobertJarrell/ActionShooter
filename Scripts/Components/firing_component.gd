class_name  FiringComponent

extends Node

@export var bullet_spawn : SpawnerComponent
@onready var spawner_component = $"../SpawnerComponent"

func _ready():
	bullet_spawn = spawner_component
	

func fire(muzzle : Node3D):
	
	bullet_spawn.spawn(muzzle.global_transform)
	
