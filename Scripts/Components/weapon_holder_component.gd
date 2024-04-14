class_name WeaponHolderComponent

extends Node3D

@export var controller : ControllerComponent
@export var weapon : Weapon
@export var grip_point : Marker3D
@export var holster_point : Marker3D

var weapon_stash : Array[Weapon] = []
var weapon_index : int = 0
var stash_size : int = 0
var max_stash_size : int = 2 
var weapon_active : bool = false

signal weapon_equipped(weapon : Weapon)
signal weapon_changed(weaopon : Weapon)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#link to the controller signal for shooting
	controller.shoot.connect(Fire)
	
	#check to see if there is a starting weapon and set position and activate variables
	if weapon:
		weapon.equipped = true
		weapon.global_transform = grip_point.global_transform
		weapon_active = true
	



#calls the current active weapon's trigger function
func Fire():
	
	if weapon:
		if weapon_active:
			weapon.pull_trigger()
		
	

#acquire a picked up weapon
func equip(new_weapon : Weapon):
	#increases the stashes current size
	stash_size += 1
	
	#identify if a weapon already exists
	if weapon:
		#make sure the stash size hasn't gone over the stash size limit
		#if it has, call the drop function
		if stash_size > max_stash_size:
			drop(weapon)
		
		#check to see if the current weapon is drawn
		#if so, holster the weapon
		if weapon_active:
			holster_weapon(weapon)
		
	
	#proceed to reparent the weapon, set its equip status, set it to active, place it into grip
	#the weapon stash array should be appended to fit needs
	var root = new_weapon.get_parent()
	root.remove_child(new_weapon)
	add_child(new_weapon)
	weapon_stash.append(new_weapon)
	weapon = new_weapon
	weapon.equipped = true 
	weapon_active = true
	weapon.global_transform = grip_point.global_transform
	
	#signal a change of weapon
	weapon_equipped.emit(weapon)
	

#drops a weapon from the weapon stash onto the current scene
func drop(dropped_weapon : Weapon):
	
	remove_child(dropped_weapon)
	get_tree().current_scene.add_child(dropped_weapon)
	weapon_index -= 1
	stash_size -= 1
	
	#initial weapon index might be at 0 make sure it doesnt stay in the negatives
	if weapon_index < 0:
		weapon_index = 0
	
	#resize the stash size to fit the current amount of weapons in possession
	var new_size : int = 0
	for child in get_children():
		var held_weapon = child as Weapon
		if held_weapon:
			new_size += 1
	
	weapon_stash.resize(new_size)
	


func holster_weapon(current_weapon):
	if weapon.global_transform == grip_point.global_transform:
		
		weapon.global_transform = holster_point.global_transform
		weapon_active = false
	
	else:
		
		weapon.global_transform = grip_point.global_transform
		weapon_active = true
	

func change_weapon():
	
	var switched_active_weapon : bool = false
	
	#chech to see if stash size is over 1
	#if not, nothing needs to happen
	if stash_size > 1:
		#check if the current weapon is active and if so holster it
		#set the wsitching active bool to true so that the changed weapon will directcly be drawn
		if weapon_active:
			holster_weapon(weapon)
			switched_active_weapon = true
		
		weapon_index += 1
		#check for array wrap around, setting weapon index to 0 if it increases over
		#the stash array limit
		if weapon_index > stash_size - 1:
			weapon_index = 0
	
		weapon = weapon_stash[weapon_index]
	
		if switched_active_weapon:
			holster_weapon(weapon)
		
		#signal a change of weapon
		weapon_changed.emit(weapon)
	
