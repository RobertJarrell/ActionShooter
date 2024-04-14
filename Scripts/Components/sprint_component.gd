class_name SprintComponent
extends Node

const DASH_TIME_RESET = 0.2
const SPRINT_COST_RESET = 0.6

@export var sheet : MoveStats
@export var state : StateComponent
@export var stamina_component : StaminaComponent
@export var controller : ManualControllerComponent
@export var model : CharacterBody3D

@export var sprint_multiplier : float = 2.5
@export var acceleration : float = 5

var dash_time : float = 0
var has_dashed : bool = false
var dash_cost : int = 10
var sprint_cost : int = 1
var sprint_cost_tick : float = 0

var speed : float
var sprint_speed : float
var wall_run_speed : float
var dash_speed : float

func _ready():
	
	speed = sheet.speed
	sprint_speed = speed * sprint_multiplier
	wall_run_speed = speed * sprint_multiplier * 0.5
	dash_speed = speed * sprint_multiplier * 1.5
	
	controller.sprint.connect(Handle_sprint)
	

func _physics_process(delta):
	
	if state.grounded:
		has_dashed = false
	
	if state.sprinting:
		if sprint_cost_tick <= 0:
			
			stamina_component.change_stamina(-sprint_cost)
			sprint_cost_tick = SPRINT_COST_RESET
			
		else:
			sprint_cost_tick += - delta
			
	if dash_time <= 0:
		state.dashing = false
		
	else:
		dash_time += -delta
		
	

func Handle_sprint(direction : Vector3, delta : float):
	if direction and stamina_component.current_stamina > 10:
		if state.grounded:
			if Input.is_action_just_pressed("Crouch"):
				dash(direction, delta)
			sprint_action(direction, delta)
			
		elif model.is_on_wall():
			var normal = model.get_slide_collision(0).get_normal()
			wall_run(normal, delta)
			
		else:
			dash(direction, delta)
	else:
		state.sprinting = false
		state.dashing = false
	

func sprint_action(direction : Vector3, delta : float):
	model.velocity.x = direction.x * sprint_speed
	model.velocity.z = direction.z * sprint_speed
	state.sprinting = true

func wall_run(wall_normal : Vector3, delta : float):
	pass

func dash(direction : Vector3, delta : float):
	
	state.dashing = true
	state.sprinting = false
	dash_time = DASH_TIME_RESET
	stamina_component.change_stamina(-dash_cost)
	
