class_name PlayerHUD
extends Control

@export var player_sheet : VitalStats
@export var weapon_holder : WeaponHolderComponent

@onready var health_gauge = $VitalStats/MarginContainer/GridContainer/HealthGauge
@onready var stamina_gauge = $VitalStats/MarginContainer/GridContainer/VSplitContainer/StaminaGauge
@onready var mana_gauge = $VitalStats/MarginContainer/GridContainer/VSplitContainer/ManaGauge
@onready var weapon_icon = $WeaponStats/MarginContainer/GridContainer/WeaponIcon
@onready var current_ammo = $WeaponStats/MarginContainer/GridContainer/CurrentAmmo
@onready var ammo_pool = $WeaponStats/MarginContainer/GridContainer/AmmoPool

var max_health : int
var current_health : int
var max_stamina : int
var current_stammina : int
var max_mana : int
var current_mana : int
var current_weapon_icon : Color
var current_ammo_count : int
var current_ammo_pool : int

var ammo_pool_text = ("/" + str(current_ammo_pool))
var current_ammo_text = str(current_ammo_count)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#initialize vital stats
	max_health = player_sheet.health
	max_stamina = player_sheet.stamina
	max_mana = player_sheet.mana
	current_health = max_health
	current_stammina = max_stamina
	current_mana = max_mana
	health_gauge.max_value = max_health
	stamina_gauge.max_value = max_stamina
	mana_gauge.max_value = max_mana
	
	update_health_value(current_health)
	update_stamina_value(current_stammina)
	update_mana_value(current_mana)
	
	#connect to vital stat signals
	player_sheet.health_changed.connect(update_health_value)
	player_sheet.stamina_changed.connect(update_stamina_value)
	player_sheet.mana_changed.connect(update_mana_value)
	
	#check if there is a current weapon.
	#if a weapon exists, initialize weapon stats
	#if not, set to null factors
	monitor_weapon_stats()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	monitor_weapon_stats()
	


func monitor_weapon_stats():
	if weapon_holder.weapon and weapon_holder.weapon_active:
		current_weapon_icon = Color.GREEN
		current_ammo_pool = weapon_holder.weapon.ammo_pool
		current_ammo_count = weapon_holder.weapon.current_ammo
		
	else:
		current_weapon_icon = Color.BLACK
		current_ammo_pool = 0
		current_ammo_count = 0
		
	if weapon_icon.color != current_weapon_icon || ammo_pool.text != ammo_pool_text || current_ammo.text != current_ammo_text:
		update_weapon_stats()

func update_weapon_stats():
	weapon_icon.color = current_weapon_icon
	
	if weapon_holder.weapon:
		ammo_pool.text = ammo_pool_text
		current_ammo.text = current_ammo_text
		
	elif !weapon_holder.weapon || !weapon_holder.weapon_active:
		ammo_pool.text = "/--"
		current_ammo.text = "--"
		
func update_health_value(value):
	health_gauge.value = value
	
	
func update_stamina_value(value):
	stamina_gauge.value = value
	
	
func update_mana_value(value):
	mana_gauge.value = value
	
