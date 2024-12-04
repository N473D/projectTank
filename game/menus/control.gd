extends Control
var node = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tween = node.create_tween()
	var offset = get_global_mouse_position() * 0.05
	tween.tween_property(node, "position", offset, 1.0)
