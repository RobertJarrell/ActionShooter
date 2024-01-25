class_name VitalsComponent

extends Node

@export var hurtbox : HurtboxComponent

signal health_change(value)
signal mana_change(value)
signal stamina_change(value)
signal knockback(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	hurtbox.hit.connect(resolve_hit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func resolve_hit(hitbox : HitboxComponent):
	
	if not hitbox is HitboxComponent:
			health_change.emit(hitbox.value)
			mana_change.emit(hitbox.value)
			stamina_change.emit(hitbox.value)
	else:
		health_change.emit(-hitbox.value)
		knockback.emit(hitbox.force)
		
		mana_change.emit(-hitbox.value)
		
		stamina_change.emit(-hitbox.value)
		
	
