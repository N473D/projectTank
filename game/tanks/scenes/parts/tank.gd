class_name Tank extends CharacterBody2D

@export var speed = 300.0
@export var controller : ControlSystem
@export var body : Body
@export var turret : Turret

func _init() -> void:
	pass

func _ready() -> void:
	for child in self.get_children():
		if child is ControlSystem and child != controller:
			child.set_process(false)

func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_controller_component_move(direction : Vector2) -> void:
	velocity = direction * speed

func _on_controller_component_fire() -> void:
	pass # Replace with function body.


func _on_controller_component_deploy() -> void:
	pass # Replace with function body.
