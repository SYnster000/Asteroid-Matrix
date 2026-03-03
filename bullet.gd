extends Area2D

var SPEED = 900.0



func _physics_process(delta):
	position += transform.x * SPEED * delta  # vai para frente
# se sair da tela, apagar
	if not get_viewport_rect().has_point(global_position):
		queue_free()
		
		
func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	
func _on_area_entered(area):
	if area.is_in_group("asteroid"):
		area.queue_free()  # destrói o asteroide
		queue_free()       # destrói a bala
