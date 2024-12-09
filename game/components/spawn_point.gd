extends Marker2D

class_name SpawnPoint

func spawnRidged(spawnable:CharacterBody2D, vector:Vector2, rot : float):
	get_tree().get_root().add_child(spawnable)
	#print(spawnable)
	spawnable.position = get_global_position()
	#print("get_global_position", get_global_position())
	spawnable.rot = rot
	#print("rotation", rot)
	#spawnable.apply_impulse(vector, Vector2())
	spawnable.look_at(vector)
	#print("Vector", vector)
	get_tree().get_root().add_child(spawnable)
