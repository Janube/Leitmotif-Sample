extends CharacterBody2D
@export var move_speed : float = 100
@export var starting_direction : float = 0
@export var fall_acceleration = 75
@onready var idle = false

func _ready():
	$Sprite2D.scale.x = -1
	add_to_group("to_delete")
	
func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = velocity.y + (fall_acceleration * delta)
	if is_on_floor() and idle == false:
		$Sprite2D/AnimationPlayer.play("Idle")
		idle = true
