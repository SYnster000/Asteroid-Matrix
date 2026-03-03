extends Control

@onready var score = $Score:
	set(value):
		score.text = "SCORE: " + str(value)

@onready var hp = $hp:
	set(value):
		hp.text = "HP: " + str(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = str(GameState.score)
	hp = str(GameState.hp)
	
