class_name CharacterMoveComponent

extends Node

@export var sheet : MoveStats
@export var model : CharacterBody3D
@export var controller : ControllerComponent
@export var state : StateComponent

var speed : float
var acceleration : float = 3
var friction : float = .15
# Called when the node enters the scene tree for the first time.
func _ready():
	
	speed = sheet.speed
	
	controller.walk.connect(Handle_move)
	

#early calculations and conditions
func Handle_move(direction : Vector3, delta : float):
	
	if not state.dashing or state.sprinting:
		move(direction, delta)
	
#basic walk logic
func move(direction : Vector3, delta : float):
	
	if direction:
		model.velocity.x = lerp(model.velocity.x, direction.x * speed, acceleration * delta)
		model.velocity.z = lerp(model.velocity.z, direction.z * speed, acceleration * delta)
	
	else:
		model.velocity.x = move_toward(model.velocity.x, 0 , friction)
		model.velocity.z = move_toward(model.velocity.z, 0, friction)
		
