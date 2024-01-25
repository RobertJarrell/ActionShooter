class_name Fireball

extends ProjectileComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	range = sheet.range
	
	hitbox.hit_hurtbox.connect(_resolve_collision)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_existance(delta)
	

func _resolve_collision():
	queue_free()

func _handle_existance(delta):
	
	range -= delta
	
	if range <= 0:
		queue_free()
		
