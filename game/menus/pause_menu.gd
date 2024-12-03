extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	Global.despawn_tanks()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/menu_screen.tscn")

func _on_resume_pressed() -> void:
	toggle()
	
func toggle() -> void:
	if !self.visible:
		self.visible = true
		get_tree().paused = true
		print("bismullah")
	else:
		self.visible = false
		get_tree().paused = false
