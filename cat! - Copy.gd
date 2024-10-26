extends CharacterBody2D
@export var move_speed : float = 100
@export var starting_direction : float = 0
@export var fall_acceleration = 75
@export var jump_impulse = 50
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var root = get_node("/root/Game Level")



func _ready():
	animation_tree.set_active(true)
	update_animation_parameters(starting_direction)
	add_to_group("player")
	
func _physics_process(delta):

	var input_direction = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	update_animation_parameters(input_direction)
	velocity.x = input_direction * move_speed
	move_and_slide()
	
	if not is_on_floor():
		velocity.y = velocity.y + (fall_acceleration * delta)
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= jump_impulse
		
func update_animation_parameters(input_direction : float):
	if(input_direction != 0):
		animation_tree.set("parameters/idle/blend_position", input_direction)
	pick_new_state()

func pick_new_state():
	if (velocity.x != 0):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

func dialogue():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	set_physics_process(false)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	set_physics_process(true)
	root.done_talking()
