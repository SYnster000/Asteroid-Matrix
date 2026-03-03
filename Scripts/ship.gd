extends CharacterBody2D

var ACCELERATION = 600.0
var MAX_SPEED = 350.0
var FRICTION = 0.98
var ROTATION_SPEED = 5.0  # velocidade de giro (maior = gira mais rápido)

signal died

@onready var muzzle = $Muzzle
var BulletScene = preload("res://Scenes/bullet.tscn")

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	
	# --- ROTAÇÃO SUAVE EM DIREÇÃO AO MOUSE ---
	var target_angle = (mouse_pos - global_position).angle()
	rotation = lerp_angle(rotation, target_angle, ROTATION_SPEED * delta)

	# --- ACELERAÇÃO NA DIREÇÃO DA NAVE ---
	if Input.is_action_pressed("thrust"):
		var forward = Vector2(1, 0).rotated(rotation)
		velocity += forward * ACCELERATION * delta

	# Aplicar atrito
	velocity *= FRICTION

	# Limitar velocidade
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	move_and_slide()
	
	# --- tiro ---
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
		
func shoot():
	var bullet = BulletScene.instantiate()
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation  # atira para frente
	get_tree().current_scene.add_child(bullet)
	
	
func take_damage(amount: int):
	GameState.hp -= amount
	print("HP:", GameState.hp)
	if GameState.hp <= 0:
		die()

func die():
	print("PLAYER MORREU")
	emit_signal("died")
	queue_free()
