extends ControlSystem

@export var controller_id : int = 0

func _process(_delta: float) -> void:
	#set_process(false)
	move_direction = Input.get_vector("move_left_control_%s" % controller_id, "move_right_control_%s" % controller_id, "move_up_control_%s" % controller_id, "move_down_control_%s" % controller_id)
	emit_signal("move", move_direction)
	if Input.is_action_pressed("attack_control_%s" % controller_id):
			emit_signal("fire")


func _input(event: InputEvent) -> void:
	if is_processing():
		if controller_id == 0:
			if event is InputEventMouseMotion:
				#print(event.relative.normalized())
				target_direction = get_global_mouse_position() - get_parent().global_position
		else:
			if event.is_action("aim_left_control_%s" % controller_id) or event.is_action("aim_right_control_%s" % controller_id) or event.is_action("aim_up_control_%s" % controller_id) or event.is_action("aim_down_control_%s" % controller_id):
				target_direction = Input.get_vector("aim_left_control_%s" % controller_id, "aim_right_control_%s" % controller_id, "aim_up_control_%s" % controller_id, "aim_down_control_%s" % controller_id)
		emit_signal("target", target_direction)
