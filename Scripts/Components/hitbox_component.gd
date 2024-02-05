class_name HitboxComponent

extends Area3D

@export var sheet : DamageStats

var value : int
var force : float

signal hit_hurtbox(hurtbox)

# Called when the node enters the scene tree for the first time.
func _ready():
	value = sheet.damage
	force = sheet.knockback_force
	
	area_entered.connect(_on_hurtbox_enterd)
	


func _on_hurtbox_enterd(hurtbox : HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	
	hit_hurtbox.emit(hurtbox)
	
	hurtbox.hit.emit(self)
	
