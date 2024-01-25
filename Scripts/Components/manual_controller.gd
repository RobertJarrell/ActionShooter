class_name ManualControllerComponent

extends ControllerComponent

@export var model : CharacterBody3D

signal walk(direction, delta)
signal jump()
signal wall_dash(direction, wall_normal,  delta)
signal side_step(direction, delta)
signal sprint(direction, delta)
signal apply_gravity(delta)
signal facing(direction)
signal weapon_recharge
signal shoot
signal strike


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_dir = Input.get_vector("Left", "Right", "Forward","Backward")
	var direction = (model.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized())
	var wall_direction = (model.transform.basis * Vector3(input_dir.x, input_dir.y, 0).normalized())
	
	_handle_jump(direction, delta)
	
	_handle_quick_action(direction, delta)
	
	_handle_move(direction, delta)
	
	_handle_attack()
	
	_handle_recharge_call()
	
	facing.emit(direction)
	

func _handle_jump(direction, delta):
	
	if Input.is_action_just_pressed("Jump"):
		print(str(model.velocity.y))
		jump.emit()
		print(str(model.velocity.y))
	
	
	apply_gravity.emit(delta)
	

func _handle_quick_action(direction, delta):
	pass

func _handle_move(direction, delta):
	if model.is_on_floor():
		walk.emit(direction, delta)
	

func _handle_attack():
	if Input.is_action_just_pressed("Fire"):
		print("firing laser")
		shoot.emit()
	
func _handle_recharge_call():
	if Input.is_action_just_pressed("Recharge"):
		weapon_recharge.emit()
