class_name JumpComponent

extends Node

@export var sheet : MoveStats
@export var controller : ControllerComponent
@export var state : StateComponent
@export var model : CharacterBody3D

var jump_force : float

var fall_off : float

var bounce_direction = Vector3.ZERO
var has_jumped : bool = false
var has_double_jumped : bool = false
var gravity_multiplier : float = 3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	jump_force = sheet.jump_strength
	fall_off = jump_force + 1
	
	controller.jump.connect(_handle_jump)
	controller.apply_gravity.connect(_handle_gravity)
	
func _physics_process(delta):
	
	if state.bounce_time > 0:
		state.bounce_time += -delta
		
	if state.grounded and state.bounce_time > 0:
		jump(bounce_direction)



func jump(direction : Vector3):
	var jump_velocity = direction * jump_force * 0.25 + Vector3.UP * jump_force
	model.velocity = jump_velocity
	

func wall_jump(wall_normal : Vector3):
	
	var push_force = jump_force * 0.5
	model.velocity = Vector3(wall_normal.x * push_force, jump_force, wall_normal.z * push_force)
	

func _handle_jump(direction : Vector3):
	
	if !state.clinging || !state.climbing:
		if state.grounded:
			jump(direction)
		
		elif !state.grounded and state.coyote_time > 0:
			jump(direction)
			
		elif model.is_on_wall():
			var wall_normal = model.get_slide_collision(0).get_normal()
			wall_jump(wall_normal)
		else:
			state.bounce_time = state.BOUNCE_RESET
			bounce_direction = direction
	

func _handle_gravity(delta):
	
	if model.velocity.y > 0 and Input.is_action_pressed("Jump") || model.velocity.y < fall_off:
		model.velocity.y -= gravity_multiplier * gravity * delta

