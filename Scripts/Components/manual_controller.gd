class_name ManualControllerComponent

extends ControllerComponent

@export var model : CharacterBody3D

signal walk(direction, delta)
signal jump(direction)
signal sprint(direction, delta)
signal apply_gravity(delta)
signal facing(direction)
signal weapon_recharge
signal shoot
signal strike


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_dir = Input.get_vector("Left", "Right", "Forward","Backward")
	var direction = (model.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized())
	
	_handle_jump(direction, delta)
	
	_handle_quick_action(direction, delta)
	
	_handle_move(direction, delta)
	
	_handle_attack()
	
	_handle_recharge_call()
	
	facing.emit(direction)
	

func _handle_jump(direction, delta):
	
	if Input.is_action_just_pressed("Jump"):
		jump.emit(direction)
		
	apply_gravity.emit(delta)
	

func _handle_quick_action(direction, delta):
	
	if Input.is_action_just_pressed("Action"):
		sprint.emit(direction, delta)
	

func _handle_move(direction, delta):
	if model.is_on_floor():
		walk.emit(direction, delta)
	

func _handle_attack():
	
	if Input.is_action_just_pressed("Strike"):
		strike.emit()
	
	if Input.is_action_just_pressed("Fire"):
		shoot.emit()
	
func _handle_recharge_call():
	if Input.is_action_just_pressed("Recharge"):
		weapon_recharge.emit()
