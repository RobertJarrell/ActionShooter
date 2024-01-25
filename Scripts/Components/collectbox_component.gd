class_name CollectboxComponent

extends Area3D

@export var sheet : VitalStats

var value : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_hurtbox_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_hurtbox_entered(hurtbox : HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	
	hurtbox.hit.emit(self)
	
