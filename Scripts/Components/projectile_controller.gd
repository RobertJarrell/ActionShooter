class_name  ProjectileController

extends ControllerComponent

signal propel(delta)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	propel.emit(delta)
