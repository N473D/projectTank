extends Node2D

class_name SpawnPoint

func spawnRidged(spawnable:RigidBody2D, vector:Vector2, rot : float):
	get_tree().get_root().add_child(spawnable)
	#print(spawnable)
	spawnable.position = get_global_position()
	#print("get_global_position", get_global_position())
	spawnable.rotation = rot
	#print("rotation", rot)
	spawnable.apply_impulse(vector, Vector2())
	#print("Vector", vector)
	spawnable.scale = Vector2(0.1, 0.1)
