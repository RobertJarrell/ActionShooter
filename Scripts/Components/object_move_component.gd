class_name ObjectMoveComponent

extends Node

@export var sheet : MoveStats
@export var controller : ControllerComponent
@export var model : Node3D

var speed : float


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = sheet.speed
	
	controller.propel.connect(move)
	


func move(delta):
	model.position = model.position + -model.global_transform.basis.z * speed * delta
