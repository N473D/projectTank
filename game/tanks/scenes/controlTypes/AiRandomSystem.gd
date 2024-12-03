extends "res://tanks/scenes/controlTypes/ControlSystem.gd"

var navigation_agent : NavigationAgent2D
var player : Node2D
var raycast: RayCast2D

var change_direction_timer = 0.0
var change_direction_interval = 2.0 # Change direction every 2 seconds

func _ready():
	randomize()
	change_direction()
	# Find the player node; ensure the player's name is "Player"
	player = get_node("/root/Node2D/Player")
	if player == null:
		print("Error: Player node not found.")
	# Initialize the raycast variable
	raycast = get_node("/root/Node2D/RandomBot/RayCast2D")  # Adjust the path as needed
	if raycast == null:
		print("Error: RayCast2D node not found.")


func _physics_process(delta):
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		change_direction()
	emit_signal("move", move_direction)
	update_target()
	emit_signal("target", target_direction)
	if can_fire():
		emit_signal("fire")

func change_direction():
	change_direction_timer = change_direction_interval
	move_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()

func update_target():
	if player:
		target_direction = (player.global_position - get_parent().global_position).normalized()
		# Set the cast_to position relative to the RayCast2D's position
		raycast.target_position = target_direction * 5000
	else:
		target_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
		raycast.target_position = target_direction * 500
	raycast.enabled = true
	emit_signal("target", target_direction)
	
	
func can_fire():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == player:
			return randf() < 0.00  #  5% chance to fire if player is in sight
	return false
