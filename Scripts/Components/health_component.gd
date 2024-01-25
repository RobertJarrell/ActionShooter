class_name HealthComponent

extends Node

@export var sheet : VitalStats
@export var model : Node3D
@export var vitals : VitalsComponent

var max_health : int
var point_value : int
var current_health : int

var regen_time = 5
var max_regen_time = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = sheet.health
	point_value = sheet.value
	current_health = max_health
	
	vitals.health_change.connect(change_health)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if regen_time <= 0:
		
		regen_health()
		regen_time = max_regen_time
	
	if current_health < max_health:
		regen_time -= delta
		


func change_health(value):
	current_health += value
	if current_health > max_health:
		current_health = max_health
	
	sheet.health_changed.emit(current_health)
	

func regen_health():
	var health_regen = 5
	if current_health < max_health:
		change_health(health_regen)
	
