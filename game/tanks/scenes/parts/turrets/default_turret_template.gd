extends Node2D

class_name Turret

@export var rotation_speed : float = 0.5
var roateTo : float = 0.0


func _on_controller_component_target(targeting : Vector2) -> void:
	#print("Vector: ", targeting)
	if targeting != Vector2.ZERO:
		roateTo = targeting.angle()
	
func _process(_delta: float) -> void:
	#print("Before: ", rotation)
	var theta = 0
	if roateTo != rotation:
		theta = wrapf((rotation - (roateTo - (PI/2))), -PI, PI)
	rotation += clamp((TAU * rotation_speed) * get_process_delta_time(), 0, abs(theta)) * sign(theta)
	roateTo = rotation
	#print("Between: ", theta)
	#print("Target: ", roateTo)
	#print("After: ", rotation)

func fire_bullet(_delta: float) -> bool:
	return false
