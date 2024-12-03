extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tank in Global.playerTanks:
		get_tree().get_root().add_child(tank)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
