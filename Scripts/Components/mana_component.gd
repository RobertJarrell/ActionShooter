class_name ManaComponent

extends Node

@export var sheet : VitalStats
@export var model : Node3D
@export var vitals : VitalsComponent

var max_mana : int
var current_mana : int

var regen_time = 5
var max_regen_time = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	max_mana = sheet.mana
	current_mana = max_mana
	
	vitals.mana_change.connect(change_mana)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if regen_time <= 0:
		regen_mana()
		regen_time = max_regen_time
	
	if current_mana < max_mana:
		regen_time -= delta
		
	

func change_mana(value):
	current_mana += value
	if current_mana > max_mana:
		current_mana = max_mana
	sheet.mana_changed.emit(current_mana)
	
func regen_mana():
	var mana_regen = 5
	if current_mana < max_mana:
		change_mana(mana_regen)
	
