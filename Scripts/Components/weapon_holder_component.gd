class_name WeaponHolderComponent

extends Node3D

@export var controller : ControllerComponent
@export var weapon : Weapon

@export var grip_point : Marker3D
@export var holster_point : Marker3D

var weapon_active : bool = false

signal weapon_equipped(weapon : Weapon)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	controller.shoot.connect(Fire)
	
	if weapon:
		weapon.equipped = true
		weapon.global_transform = grip_point.global_transform
		weapon_active = true
	




func Fire():
	
	if weapon:
		if weapon_active:
			weapon.pull_trigger()
		
	

func equip(new_weapon : Weapon):
	weapon = new_weapon
	new_weapon.equipped = true
	weapon.global_transform = grip_point.global_transform
	

func drop():
	pass

func holster_weapon():
	if weapon.global_transform == grip_point.global_transform:
		
		weapon.global_transform = holster_point.global_transform
		weapon_active = false
	
	else:
		
		weapon.global_transform = grip_point.global_transform
		weapon_active = true
	
