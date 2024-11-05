extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_pressed() -> void:
	Global.set_previous_screne(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://game_won_screen.tscn")


func _on_lose_pressed() -> void:
	Global.set_previous_screne(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://game_lost_screen.tscn")
