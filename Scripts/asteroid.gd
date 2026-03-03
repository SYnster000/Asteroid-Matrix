extends Area2D


var movement_vector := Vector2(0, -1)

var speed := 150



func  _ready() -> void:
	rotation = randf_range(0, 2*PI)
	add_to_group("asteroid")
	connect("area_entered", Callable(self, "_on_area_entered"))
	#hp = max_hp

func _on_area_entered(area):
	if area.is_in_group("player_hitbox"):
		area.get_parent().take_damage(1)   # causa 1 de dano no player	

func get_radius_from_collision() -> float:
	var poly: PackedVector2Array = $CollisionPolygon2D.polygon
	var max_dist := 0.0

	for p in poly:
		var dist := p.length()
		if dist > max_dist:
			max_dist = dist
	return max_dist


func  _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	
	var radius = get_radius_from_collision() * 0.3
	var screen_size = get_viewport_rect().size
	
	# Para baixo → aparece em cima
	if global_position.y - radius > screen_size.y:
		global_position.y = -radius

# Para cima → aparece embaixo
	elif global_position.y + radius < 0:
		global_position.y = screen_size.y + radius

# Para direita → aparece na esquerda
	if global_position.x - radius > screen_size.x:
		global_position.x = -radius

# Para esquerda → aparece na direita
	elif global_position.x + radius < 0:
		global_position.x = screen_size.x + radius
		
		
