class_name StaminaComponent

extends Node

@export var sheet : VitalStats
@export var model : Node3D
@export var vitals : VitalsComponent

var max_stamina : int
var current_stamina : int

var regen_time = 5
var max_regen_time = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	max_stamina = sheet.stamina
	current_stamina = max_stamina
	
	vitals.stamina_change.connect(change_stamina)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if regen_time <= 0:
		regen_stamina()
		regen_time = max_regen_time
	
	if current_stamina < max_stamina:
		regen_time -= delta


func change_stamina(value):
	current_stamina += value
	if current_stamina > max_stamina:
		current_stamina = max_stamina
		
	sheet.stamina_changed.emit(current_stamina)
	
func regen_stamina():
	var stamina_regen = 5
	if current_stamina <= max_stamina:
		change_stamina(stamina_regen)
	
