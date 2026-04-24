# Player Car Script - Controla o carro do jogador
extends CharacterBody2D

# Variáveis de velocidade e movimento
var speed = 0.0
var max_speed = 310.0  # km/h máximo
var acceleration = 5.0
var deceleration = 3.0
var friction = 1.5

# Variáveis de câmbio
var current_gear = 1
var max_gear = 7
var gear_speed_ranges = [0, 50, 100, 150, 200, 250, 310]  # km/h por marcha

# Variáveis de direção
var rotation_speed = 0.05
var current_rotation = 0.0

# Variáveis de controle touch
var touch_position = Vector2.ZERO
var is_accelerating = false
var is_braking = false

func _ready():
	print("🏎️ Player Car iniciado!")
	set_physics_process(true)

func _physics_process(delta):
	# Captura entrada touch
	handle_touch_input()
	
	# Atualiza velocidade
	update_speed(delta)
	
	# Atualiza câmbio automático
	update_gear()
	
	# Movimento do carro
	velocity = Vector2(cos(current_rotation), sin(current_rotation)) * speed
	position += velocity * delta
	
	# Rotação do carro
	rotate_car(delta)

func handle_touch_input():
	# Detecta toque na tela
	for event in get_tree().get_root().get_input_event(0, 0):
		if event is InputEventScreenTouch:
			if event.pressed:
				touch_position = event.position
				# Se tocar na parte inferior direita = acelerar
				if event.position.y > get_viewport_rect().size.y / 2:
					is_accelerating = true
					is_braking = false
				# Se tocar na parte inferior esquerda = frear
				selif event.position.x < get_viewport_rect().size.x / 2:
					is_braking = true
					is_accelerating = false
			else:
				is_accelerating = false
				is_braking = false

func update_speed(delta):
	# Aceleração
	if is_accelerating and speed < max_speed:
		speed += acceleration * delta * 60
	# Frenagem
	elif is_braking:
		speed -= deceleration * delta * 60
	# Atrito natural
	else:
		speed -= friction * delta * 60
	
	# Limita a velocidade
	speed = clamp(speed, 0, max_speed)

func update_gear():
	# Câmbio automático baseado na velocidade
	for i in range(max_gear):
		if speed >= gear_speed_ranges[i] and speed < gear_speed_ranges[i + 1]:
			current_gear = i + 1
			break

func rotate_car(delta):
	# Rotação baseada na posição do toque
	if touch_position.x > get_viewport_rect().size.x / 2:
		current_rotation += rotation_speed
	elif touch_position.x < get_viewport_rect().size.x / 2:
		current_rotation -= rotation_speed

func get_speedometer():
	# Retorna a velocidade atual em km/h
	return int(speed)

func get_current_gear():
	# Retorna a marcha atual
	return current_gear