extends CharacterBody2D
class_name player

const move_speed : float = 100.0
const jump_speed : float = 300.0
@onready var movement : movement = $"Movement" as movement
@onready var animation = $AnimatedSprite2D
var is_facing_right : bool = true

func _ready() -> void:
	add_to_group("player")
	movement._setup(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	movement._update(delta, Input.get_axis("move_left","move_right"))
	movement._jump(delta)
	flip()
	apply_anim()
	move_and_slide()

func flip():
	pass

# ANIMATIONS

func apply_anim():
	if velocity.x != 0:
		animation.play("Run")
		
		animation.flip_h = velocity.x < 0 # True si va a la izquierda
	else:
		animation.play("Idle")
