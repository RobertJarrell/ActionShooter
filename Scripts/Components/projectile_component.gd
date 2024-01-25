class_name ProjectileComponent

extends Node3D

@export var sheet : AmmoData
@export var hitbox : HitboxComponent

var range : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _resolve_collision():
	pass
