class_name SpawnerComponent

extends Node3D

@export var scene : PackedScene



func spawn(spawn_position : Transform3D = global_transform, parent : Node = get_tree().current_scene) -> Node:
	var instance = scene.instantiate()
	
	parent.add_child(instance)
	
	instance.global_transform = spawn_position
	
	return instance 
	
