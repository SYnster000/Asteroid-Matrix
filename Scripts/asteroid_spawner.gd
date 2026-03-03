extends Node2D

@export var asteroid_scene: PackedScene
@export var max_on_screen: int = 5
@export var spawn_limit: int = -1   # -1 para infinito
@export var spawn_interval: float = 1.5

var spawned_total := 0
var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	start_spawning()


func start_spawning():
	spawn_next()


func spawn_next():
	# Verifica limite total
	if spawn_limit != -1 and spawned_total >= spawn_limit:
		return

	# Verifica limite simultâneo
	var current = count_asteroids()
	if current < max_on_screen:
		spawn_asteroid()
		spawned_total += 1

	# chama novamente depois do intervalo
	await get_tree().create_timer(spawn_interval).timeout
	spawn_next()


func spawn_asteroid():
	if asteroid_scene == null:
		push_error("asteroid_scene não está configurado!")
		return
	
	var asteroid = asteroid_scene.instantiate()

	# Define posição aleatória nas bordas da tela
	var screen = get_viewport_rect().size
	var x := 0.0
	var y := 0.0

	var side = rng.randi_range(0, 3)  # 0 top, 1 right, 2 bottom, 3 left

	match side:
		0:  # topo
			x = rng.randf_range(0, screen.x)
			y = -50
		1:  # direita
			x = screen.x + 50
			y = rng.randf_range(0, screen.y)
		2:  # baixo
			x = rng.randf_range(0, screen.x)
			y = screen.y + 50
		3:  # esquerda
			x = -50
			y = rng.randf_range(0, screen.y)

	asteroid.global_position = Vector2(x, y)
	get_parent().call_deferred("add_child", asteroid)


func count_asteroids() -> int:
	var count := 0
	for child in get_parent().get_children():
		if child.is_in_group("asteroid"):
			count += 1
	return count
