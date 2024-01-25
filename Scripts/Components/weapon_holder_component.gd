class_name WeaponHolderComponent

extends Node3D

@export var controller : ControllerComponent
@export var weapon : Weapon

@export var grip_point : Marker3D
@export var holster_point : Marker3D

var weapon_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	controller.shoot.connect(Fire)
	
	if weapon:
		weapon.equipped = true
		weapon.global_position = grip_point.global_position
		weapon_active = true
	




func Fire():
	
	if weapon:
		if weapon_active:
			weapon.pull_trigger(weapon.muzzle)
			print("Shooting")
	

func equip(new_weapon : Weapon):
	weapon = new_weapon
	new_weapon.equipped = true
	weapon.global_position = grip_point.global_position
	

func drop():
	pass

func holster_weapon():
	if weapon.global_position == grip_point.global_position:
		
		weapon.global_position = holster_point.global_position
		weapon_active = false
	
	else:
		
		weapon.global_position = grip_point.global_position
		weapon_active = true
	
