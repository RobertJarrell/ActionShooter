class_name PlayerToken

extends CharacterBody3D

@export var controller : ControllerComponent
@export var sheet : VitalStats

@onready var state = $StateComponent
@onready var weapon_holder = $WeaponHolderComponent as WeaponHolderComponent
@onready var visuals = $Visuals
@onready var initial_position = transform.origin
@onready var player_hud = $PlayerHud
@onready var color_rect = player_hud.get_node("ColorRect")

var current_health : int
var current_mana : int
var current_stamina : int
var weapon : Weapon

var just_left_floor : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = sheet.health
	current_mana = sheet.mana
	current_stamina = sheet.stamina
	weapon = weapon_holder.weapon
	
	weapon_holder.weapon_equipped.connect(change_weapon)
	sheet.health_changed.connect(monitor_health)
	sheet.mana_changed.connect(monitor_mana)
	sheet.stamina_changed.connect(monitor_stamina)
	controller.facing.connect(face)
	controller.weapon_recharge.connect(reload)
	

func _input(event):
	var mouse_motion = event as InputEventMouseMotion
		
	if mouse_motion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-mouse_motion.relative.x * .05))
		
	

func _process(delta):
	if Input.is_action_just_pressed("Toggle Mouse Capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
			
	if transform.origin.y < -17:
		color_rect.modulate.a = min((-17 - transform.origin.y)/15, 1)
		if transform.origin.y < -40:
			transform.origin = initial_position
		
	else:
		color_rect.modulate.a *= 1.0 * delta * 4
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if state.coyote_time > 0:
		state.coyote_time += -delta
	
	
	state.grounded = is_on_floor()
	
	move_and_slide()
	
	just_left_floor = state.grounded and not is_on_floor()
	
	if just_left_floor:
		state.coyote_time = state.COYOTE_RESET
	
	

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
	
	if not weapon:
		return
	
	var recharge_mana : int
	var recharge_amount = weapon.max_current_ammo - weapon.current_ammo
	
	if current_mana < recharge_amount:
		
		recharge_mana = current_mana
		
	
	else:
		
		recharge_mana = recharge_amount
		
	
	weapon.recharge(recharge_mana)
	sheet.mana_changed.emit(-recharge_mana)

