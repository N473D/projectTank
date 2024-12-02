extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_pressed() -> void:
#	Change level var to be the previously played level.
	var level = Global.get_previous_screne()
	get_tree().change_scene_to_file(level)


func _on_go_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/menu_screen.tscn")
