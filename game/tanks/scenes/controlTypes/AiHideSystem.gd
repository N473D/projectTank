extends "res://tanks/scenes/controlTypes/ControlSystem.gd"

var navigation_agent : NavigationAgent2D
var player : Node2D
var state: int = 0  # 0: Seeking cover, 1: Hiding, 2: Attacking
var state_timer: float = 0.0
var raycast: RayCast2D


func _ready():
	# Find the player node; ensure the player's name is "Player"
	player = get_node("/root/Node2D/Player")
	if player == null:
		print("Error: Player node not found.")
	# Initialize the raycast variable
	raycast = get_node("/root/Node2D/HideBot/RayCast2D")  # Adjust the path as needed
	if raycast == null:
		print("Error: RayCast2D node not found.")
		
	setup_navigation_agent()
	

func setup_navigation_agent():
	navigation_agent = NavigationAgent2D.new()
	add_child(navigation_agent)
	

func _physics_process(delta: float) -> void:
	hide_peekaboo_behavior(delta)
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
		raycast.target_position = target_direction * 500  # Adjust as needed
	else:
		target_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
		raycast.target_position = target_direction * 5000
	raycast.enabled = true
	emit_signal("target", target_direction)


func hide_peekaboo_behavior(delta: float) -> void:
	match state:
		0:  # Seeking cover
			var cover_position = find_cover()
			if cover_position:
				navigation_agent.target_position = cover_position
				var next_position = navigation_agent.get_next_path_position()
				if next_position:
					move_direction = (next_position - get_parent().global_position).normalized()
					get_parent().global_position += move_direction * delta * 100  # Adjust speed as needed
				else:
					move_direction = Vector2.ZERO

				if get_parent().global_position.distance_to(cover_position) < 70:
					state = 1
					state_timer = randf() * 2 + 1  # Hide for 1-3 seconds
			else:
				move_direction = Vector2.ZERO

		1:  # Hiding
			# Recalculate cover and navigate back
			move_direction = Vector2.ZERO
			state_timer -= delta
			if state_timer <= 0:
				state = 2
				state_timer = randf() * 1 + 0.5  # Attack for 0.5-1.5 seconds
			else:
				# Actively seek a cover position while waiting
				var cover_position = find_cover()
				if cover_position:
					navigation_agent.target_position = cover_position
					var next_position = navigation_agent.get_next_path_position()
					if next_position:
						move_direction = (next_position - get_parent().global_position).normalized()
						get_parent().global_position += move_direction * delta * 100
					else:
						move_direction = Vector2.ZERO

		2:  # Attacking
			if player:
				navigation_agent.target_position = player.global_position
				var next_position = navigation_agent.get_next_path_position()
				if next_position:
					move_direction = (next_position - get_parent().global_position).normalized()
					get_parent().global_position += move_direction * delta * 80  # Adjust speed as needed
				else:
					move_direction = Vector2.ZERO

				target_direction = (player.global_position - get_parent().global_position).normalized()
			else:
				move_direction = Vector2.ZERO
			state_timer -= delta
			if state_timer <= 0:
				state = 1
				state_timer = randf() * 2 + 1



func find_cover():
	var covers = get_tree().get_nodes_in_group("Cover")
	if covers.size() > 0:
		var closest_cover = covers[0]
		var min_distance = get_parent().global_position.distance_to(closest_cover.global_position)
		for cover in covers:
			var distance = get_parent().global_position.distance_to(cover.global_position)
			if distance < min_distance:
				closest_cover = cover
				min_distance = distance
		return closest_cover.global_position
	else:
		return null

func can_fire():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == player:
			return (state == 2) && (randf() < 0.05)  #  5% chance to fire if player is in sight and in attacking state
	return false
