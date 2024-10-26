extends CharacterBody2D
@export var move_speed : float = 100
@export var starting_direction : float = 0
@export var fall_acceleration = 75
@onready var idle = false
@onready var fall_poorly = false

func _ready():
	$Sprite2D.scale.x = -1
	add_to_group("to_delete")
	
func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = velocity.y + (fall_acceleration * delta)
		$Sprite2D/AnimationPlayer.play("Falling")
	if is_on_floor() and idle == false and fall_poorly == false:
		$Sprite2D/AnimationPlayer.play("Landing")
		$Dust.set_emitting(true)
		await get_tree().create_timer(1.0).timeout
		$Sprite2D/AnimationPlayer.play("Idle")
		idle = true
	elif is_on_floor() and idle == false and fall_poorly == true:
		$Sprite2D/AnimationPlayer.play("Landing2")
		$Dust.set_emitting(true)
		await get_tree().create_timer(3.0).timeout
		$Sprite2D/AnimationPlayer.play("Idle")
		idle = true
		
func fall_bad():
	fall_poorly = true
