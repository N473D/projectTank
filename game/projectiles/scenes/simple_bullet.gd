extends RigidBody2D
class_name SimpleBullet

@export var despawn:Timer

func _ready() -> void:
	gravity_scale = 0.0
	#scale = Vector2(0.1, 0.1)
	


func _on_timer_timeout() -> void:
	print("Despawned")
	self.get_parent().remove_child(self)
