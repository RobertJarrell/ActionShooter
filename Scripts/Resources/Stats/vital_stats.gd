class_name VitalStats

extends Resource

@export var health : int
@export var stamina : int
@export var mana : int
@export var value : int

signal health_changed(value)
signal stamina_changed(value)
signal mana_changed(value)
