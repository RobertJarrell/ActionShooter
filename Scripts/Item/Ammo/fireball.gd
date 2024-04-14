class_name Fireball

extends ProjectileComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	
	distance = sheet.distance
	
	hitbox.hit_hurtbox.connect(_resolve_collision)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_handle_existance(delta)
	

func _resolve_collision():
	queue_free()

func _handle_existance(delta):
	
	distance -= delta
	
	if distance <= 0:
		queue_free()
		
