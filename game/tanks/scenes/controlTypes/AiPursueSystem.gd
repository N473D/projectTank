extends "res://tanks/scenes/controlTypes/ControlSystem.gd"

var navigation_agent : NavigationAgent2D
var player : Node2D
var raycast: RayCast2D

func _ready():
	# Find the player node; ensure the player's name is "Player"
	player = get_node("/root/Node2D/Player")
	if player == null:
		print("Error: Player node not found.")
	# Initialize the raycast variable
	raycast = get_node("/root/Node2D/PursueBot/RayCast2D")  # Adjust the path as needed
	if raycast == null:
		print("Error: RayCast2D node not found.")
	
	setup_navigation_agent()
	

func setup_navigation_agent():
	navigation_agent = NavigationAgent2D.new()
	add_child(navigation_agent)

func _physics_process(delta: float) -> void:
	pursue_chase_behavior(delta)
	# Emit movement and target signals
	emit_signal("move", move_direction)
	update_target()
	emit_signal("target", target_direction)
	if can_fire():
		emit_signal("fire")
		
func update_target():
	if player:
		target_direction = (player.global_position - get_parent().global_position).normalized()
		# Set the cast_to position relative to the RayCast2D's position
		raycast.target_position = target_direction * 5000  # Adjust as needed
	else:
		target_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
		raycast.target_position = target_direction * 500
	raycast.enabled = true
	emit_signal("target", target_direction)

func pursue_chase_behavior(delta: float) -> void:
	if player and navigation_agent:
		# Set the target position for the agent
		navigation_agent.target_position = player.global_position
		# Get the next position in the path
		var next_position = navigation_agent.get_next_path_position()
		if next_position:
			# Calculate movement direction
			move_direction = (next_position - get_parent().global_position).normalized()
			target_direction = (player.global_position - get_parent().global_position).normalized()
			# Move the parent node towards the next position
			get_parent().global_position += move_direction * delta * 90 #speed

		else:
			move_direction = Vector2.ZERO
	else:
		move_direction = Vector2.ZERO
		

func can_fire():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == player:
			return randf() < 0.00  #  5% chance to fire if player is in sight
	return false
