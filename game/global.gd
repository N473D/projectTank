extends Node

var previousScene = ""
var defaultTankScene = load("res://tanks/scenes/parts/tank.tscn")
var playerTanks = [] #when updated, call updatePlayers function that will spawn in players.

func updatePlayers() -> void:
	pass

func addPlayer() -> void:
	playerTanks.append(defaultTankScene.instantiate())

func get_previous_screne() -> String:
	return previousScene
	
func set_previous_screne(scene: String) -> void:
	previousScene = scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerTanks.append(defaultTankScene.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
