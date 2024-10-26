extends CharacterBody2D
@onready var playerlocation = get_node("/root/Game Level/CAT!")
@export var move_speed : float = 2000
@export var starting_direction : float = 0
@export var fall_acceleration = 75
@onready var idle = false
@onready var spawn = true

func _ready():
	$Sprite2D.scale.x = -1
	add_to_group("to_delete")
	
func _physics_process(delta):

	if not is_on_floor():
		velocity.y = velocity.y + (fall_acceleration * delta)
	if spawn == true and position.x > playerlocation.position.x + 40:
		velocity.x = -(delta * move_speed)
		#position = position.move_toward(playerlocation.global_position + Vector2(40,0), delta*35)
	else:
		velocity.x = 0
	if velocity != Vector2.ZERO:
		$Sprite2D/AnimationPlayer.play("Running")
	else:
		$Sprite2D/AnimationPlayer.play("Idle")
	move_and_slide()
		
func done_spawning():
	spawn = false
