extends Node
class_name movement

var player : player
var air_jump : bool
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var acceleration = 1200.00
@export var friction = 1200.00

# UPDATE
func _setup(body):
	player = body

func _update(delta: float, direction: float):
	apply_gravity(delta)
	_move(Vector2(direction, 0), delta)
	_jump(delta)

# PLATFORMER MOVEMENTS

func _move(direction: Vector2, delta: float):
	player.velocity.x = move_toward(player.velocity.x, direction.x * player.move_speed, acceleration * delta)
	if direction.x == 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0, friction * delta)

func _jump(delta):
	if player.is_on_floor():
		air_jump = true
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = - player.jump_speed
	elif Input.is_action_just_pressed("jump") and air_jump:
		player.velocity.y = - player.jump_speed * 0.8
		air_jump = false

# APPLYING FORCES

func apply_gravity(delta):
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
		player.velocity.y = clampf(player.velocity.y, -1200, 980)

# ANIMATIONS
