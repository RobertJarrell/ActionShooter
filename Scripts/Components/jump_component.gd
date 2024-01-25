class_name JumpComponent

extends Node

@export var sheet : MoveStats
@export var controller : ControllerComponent
@export var model : CharacterBody3D

var jump_velocity
var fall_off : float = 12
var gravity_multiplier : float = 3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	jump_velocity = sheet.jump_strength
	#fall_off = jump_velocity + 1
	
	controller.jump.connect(jump)
	#controller.wall_jump.connect(wall_jump)
	controller.apply_gravity.connect(_handle_gravity)
	




func jump():
	
	if model.is_on_floor():
		model.velocity.y = jump_velocity
		
	
	

func wall_jump():
	if model.is_on_wall():
		var wall_normal = model.get_slide_collision(0)
		model.velocity = Vector3(wall_normal.x * jump_velocity, jump_velocity, wall_normal.z * jump_velocity)
	

func _handle_gravity(delta):
	
	if model.velocity.y > 0 and Input.is_action_pressed("Jump") || model.velocity.y < fall_off:
		model.velocity.y -= gravity_multiplier * gravity * delta

