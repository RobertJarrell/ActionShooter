class_name DetectionComponent
extends Area3D

var entity_in_range : bool = false
var entity_count : int = 1

func _ready():
	body_entered.connect(check_for_entities)
	body_exited.connect(resolve_entities_leaving)
	
	
func check_for_entities(body):
	
	if body is PlayerToken:
		entity_in_range = true
		entity_count += 1
		
	

func resolve_entities_leaving(body):
	
	if body is PlayerToken:
		entity_count -= 1
		
		if entity_count == 0:
			entity_in_range = false
			
		
	
