class_name SpawnerComponent

extends Node3D

@export var scene : PackedScene


func spawn(spawn_position : Vector3 = global_position, parent : Node = get_tree().current_scene) -> Node:
	var instance = scene.instantiate()
	
	parent.add_child(instance)
	
	instance.global_position = spawn_position
	
	print("instanced")
	
	return instance 
	
