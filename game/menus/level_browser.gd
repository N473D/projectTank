extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_pressed() -> void:
#	un-comment when levels have been built.
	#get_tree().change_scene_to_file("res://level_1.tscn")
	
	#delete when levels made
	get_tree().change_scene_to_file("res://test_level1.tscn")

func _on_level_2_pressed() -> void:
#	un-comment when levels have been built.
	#get_tree().change_scene_to_file("res://level_2.tscn")
	
	#delete when levels made
	get_tree().change_scene_to_file("res://menus/test_level.tscn")

func _on_level_3_pressed() -> void:
#	un-comment when levels have been built.
	#get_tree().change_scene_to_file("res://level_3.tscn")
	
	#delete when levels made
	get_tree().change_scene_to_file("res://menus/test_level.tscn")


func _on_level_4_pressed() -> void:
#	un-comment when levels have been built.
	#get_tree().change_scene_to_file("res://level_4.tscn")
	
	#delete when levels made
	get_tree().change_scene_to_file("res://menus/test_level.tscn")

	
func _on_level_5_pressed() -> void:
#	un-comment when levels have been built.
	#get_tree().change_scene_to_file("res://level_5.tscn")
	
	#delete when levels made
	get_tree().change_scene_to_file("res://menus/test_level.tscn")



func _on_go_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/menu_screen.tscn")
