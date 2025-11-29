extends CharacterBody2D
class_name player

const move_speed : float = 100
const jump_speed : float = 300
@onready var movement : movement = $"Movement" as movement
var is_facing_right : bool = true

func _ready() -> void:
	movement._setup(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	movement._update(delta, Input.get_axis("move_left","move_right"))
	movement._jump(delta)
	flip()
	move_and_slide()

func flip():
	pass
