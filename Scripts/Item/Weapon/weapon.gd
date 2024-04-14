class_name Weapon

extends RigidBody3D

@export var sheet : WeaponData

var trigger : FiringComponent
var muzzle : Marker3D
var current_ammo : int
var max_current_ammo : int
var rate_of_fire : float
var ammo_pool : int
var max_ammo_pool : int

var recoil_time : float = 0
var equipped : bool = false

func _check_status():
	if equipped:
		freeze = true
		freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	else:
		freeze = false
	

func pull_trigger():
	pass

func recharge(mana_value):
	pass
	

