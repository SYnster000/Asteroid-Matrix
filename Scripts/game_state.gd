extends Node


var score
var hp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func reset():
	GameState.score = 0
	GameState.hp = 5
	await get_tree().process_frame
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		GameState.reset()
