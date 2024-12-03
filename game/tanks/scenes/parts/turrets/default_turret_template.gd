extends Node2D

class_name Turret

@export var rotation_speed : float = 0.5
@export var barrelCollection : Node2D
var numBarrel  : int = 0

var rotateTo : float = 0.0

var loaded : bool = true
var readyToFire : bool = true
@export var roundsChambered : int = 1
@export var maxRounds : int = 1
@export var reloadTime : Timer
@export var fire_rate : Timer

func _on_controller_component_target(targeting : Vector2) -> void:
	#print("Vector: ", targeting)
	if targeting != Vector2.ZERO:
		rotateTo = targeting.angle()
	
func _process(_delta: float) -> void:
	#print("Before: ", rotation)
	var theta = 0
	if rotateTo != rotation:
		theta = wrapf((rotation - (rotateTo - (PI/2))), -PI, PI)
	rotation += clamp((TAU * rotation_speed) * get_process_delta_time(), 0, abs(theta)) * sign(theta)
	rotateTo = rotation
	#print("Between: ", theta)
	#print("Target: ", roateTo)
	#print("After: ", rotation)

func canFire() -> bool:
	return (loaded and readyToFire)


func _on_tank_spawn_bullet(shell, speed:int) -> void:
	barrelCollection.get_child((numBarrel % barrelCollection.get_child_count())).spawnRidged(shell.instantiate(), Vector2(speed, 0).rotated(rotation - (PI/2)), rotation)
	numBarrel += 1
	roundsChambered -= 1
	if roundsChambered <= 0:
		loaded = false
		reloadTime.start()
	roundsChambered = false
	fire_rate.start()


func _on_shot_delay_timeout() -> void:
	loaded = true


func _on_reload_delay_timeout() -> void:
	roundsChambered = true
