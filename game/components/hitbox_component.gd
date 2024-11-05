extends Area2D

class_name HitboxComponent

@export var health_comp : HealthComponent

func damage(attack: int):
	if health_comp:
		health_comp.damage(attack)
