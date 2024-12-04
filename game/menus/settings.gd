extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_go_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/menu_screen.tscn")


func _on_kbm_pressed() -> void:
#	make input device kbm
	pass # Replace with function body.


func _on_controller_pressed() -> void:
#	make input device controller
	pass # Replace with function body.
