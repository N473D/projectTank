extends CharacterBody2D
class_name SimpleBullet

@export var time:Timer
var trace_line:Array
@export var speed:int = 500
@export var bounces:int = 3
#var pos:Vector2
#var dir:Vector2
var rot:float

func _ready() -> void:
	time.set_one_shot(true)
	time.start()
	#await(get_tree().create_timer(0.3), "timeout")
	#scale = Vector2(0.1, 0.1)
	

func _on_timer_timeout() -> void:
	print("Despawned")
	#self.get_parent().remove_child(self)
	queue_free()

#func _draw() -> void:
	#if !trace_line.is_empty():
		#for i in trace_line.size() -1:
			#var p1:Vector2 = trace_line[i]
			#var p2:Vector2 = trace_line[i+1]
			#var c: = Color.WHITE
			#draw_line(p1, p2, c)

func _process(delta: float) -> void:
	#print("Dir: ", rotation, ",speed: ", speed, ",delta: ", delta)
	var move = Vector2.RIGHT.rotated(rotation) * speed * delta
	while !move.is_zero_approx() && bounces > 0:
		print("Move: ", move)
		move = _bullet_process(move)
	if bounces > 0:
		queue_free()
	#update()
	
func _physics_process(delta: float) -> void:
	if bounces > 0:
		#_bullet_process(delta)
		pass

func _bullet_process(move: Vector2) -> Vector2:
	#print("moving: ", dir * speed * delta)
	var collisionResults = move_and_collide(move)
	if collisionResults != null:
		if collisionResults is CharacterBody2D:
			queue_free()
		elif collisionResults is Tank:
			queue_free()
		elif collisionResults is SimpleBullet:
			queue_free()
		else:
			print(collisionResults.get_collider())
			bounces -= 1
			return move.bounce(Vector2.RIGHT.rotated(collisionResults.get_angle()))
			#return collisionResults.get_travel()
	return Vector2.ZERO
	#var spaceState: = get_world_2d().direct_space_state
	##var remainingLenght: = speed * delta
	#var start: Vector2 = position
	#var end: Vector2
	##trace_line.append(pos)
	#var data: Dictionary
	##
	#while bounces > 0:
		#end = start + dir
		#data = spaceState.intersect_ray(PhysicsRayQueryParameters2D.create(start, end, 2))
		##data = spaceState.intersect_ray(pos, end)
		#if data:
			#end = data.position - (data.position - start).normalized() * 0.01
			##dir = dir.bounce(data.normal).normalized()
			#bounces -= 1
			###data.collider
		#move_and_collide()
		#remainingLenght -= (end - pos).length()
		#pos = end
		#
		#trace_line
