class_name PlayerToken

extends CharacterBody3D

@export var controller : ControllerComponent
@export var sheet : VitalStats

@onready var weapon_holder = $WeaponHolderComponent


@onready var visuals = $Visuals

var current_health : int
var current_mana : int
var current_stamina : int
var weapon : Weapon

var grounded : bool = false
var just_left_floor : bool = false
var coyote_time : float = 0
var coyote_reset : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = sheet.health
	current_mana = sheet.mana
	current_stamina = sheet.stamina
	weapon = weapon_holder.weapon
	
	sheet.health_changed.connect(monitor_health)
	sheet.mana_changed.connect(monitor_mana)
	sheet.stamina_changed.connect(monitor_stamina)
	controller.facing.connect(face)
	controller.weapon_recharge.connect(reload)
	

func _input(event):
	var mouse_motion = event as InputEventMouseMotion
		
	if mouse_motion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-mouse_motion.relative.x * .05))
		
	

func _process(_delta):
	if Input.is_action_just_pressed("Toggle Mouse Capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if coyote_time > 0:
		coyote_time -= delta
		
	grounded = is_on_floor()
	
	move_and_slide()
	
	just_left_floor = grounded and not is_on_floor()
	
	if just_left_floor:
		coyote_time = coyote_reset
	

func monitor_health(value):
	current_health += value

func monitor_mana(value):
	current_mana += value

func monitor_stamina(value):
	current_stamina += value

func face(direction):
	if direction:
		visuals.look_at(direction + position)
	
func change_weapon(new_weapon):
	weapon = new_weapon


func reload():
	var recharge_mana : int
	var recharge_amount = weapon.max_current_ammo - weapon.current_ammo
	
	if current_mana < recharge_amount:
		
		recharge_mana = current_mana
		
	
	else:
		
		recharge_mana = recharge_amount
		
	
	weapon.recharge(recharge_mana)
	sheet.mana_changed.emit(-recharge_mana)

