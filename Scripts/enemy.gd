extends CharacterBody2D
class_name enemy

const MOVE_SPEED: float = 50.0
const GRAVITY: float = 980.0 
const ARRIVAL_THRESHOLD: float = 10.0

@export var patrol_points: Array[Marker2D] = []
var current_point_index: int = 0

@onready var detection_area: Area2D = $Area2D
var player: CharacterBody2D = null


func _ready() -> void:
	detection_area.body_entered.connect(_on_player_detected)
	detection_area.body_exited.connect(_on_player_lost)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	if player:
		_chase()
	else:
		_patrol()
	move_and_slide()

func _chase() -> void:
	var direction_x = sign(player.global_position.x - global_position.x)
	velocity.x = direction_x * MOVE_SPEED

func _patrol() -> void:
	if patrol_points.size() == 0:
		velocity.x = 0
		return

	var target = patrol_points[current_point_index].global_position
	
	if global_position.distance_to(target) < ARRIVAL_THRESHOLD:
		current_point_index = (current_point_index + 1) % patrol_points.size()
		target = patrol_points[current_point_index].global_position 
		
	var direction_x = sign(target.x - global_position.x)
	velocity.x = direction_x * MOVE_SPEED

func _on_player_detected(body: Node2D) -> void:
	print("¡Señal body_entered emitida! Cuerpo detectado: ", body.name)
	if body.is_in_group("player"):
		player = body as CharacterBody2D
		print("Jugador detectado: Iniciando persecución.")
		velocity.x = 0 

func _on_player_lost(body: Node2D) -> void:
	if body == player:
		player = null
		velocity.x = 0
