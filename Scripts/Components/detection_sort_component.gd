class_name DetectionSortComponent
extends Node

var viable_target_detected : bool = false
var detection_zones : Array[DetectionComponent] = []

@onready var world_detection = $"../WorldDetection"

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in world_detection.get_children():
		if child is  DetectionComponent:
			detection_zones.append(child)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_for_viable_targets()
	

func check_for_viable_targets():
	for zone in detection_zones:
		if zone.entity_in_range:
			viable_target_detected = true
			return
			
	viable_target_detected = false
	
