extends Node2D

class_name HealthComponent

@export var MAX_HEALTH := 10
var health : int

func _ready():
	health = MAX_HEALTH

func damage(attack: int):
	health -= attack
	
	if health <= 0:
		print("Tank Down")
