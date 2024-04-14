class_name  FiringComponent

extends Node

var bullet_spawn : SpawnerComponent
@onready var spawner_component = $"../SpawnerComponent"

func _ready():
	bullet_spawn = spawner_component
	

func fire(shot_origin : Node3D):
	
	bullet_spawn.spawn(shot_origin.global_transform)
	
