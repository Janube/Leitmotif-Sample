extends CharacterBody2D
@onready var red_interact = false
@onready var ui_scene = preload("res://ui_label.tscn")
@onready var ui_label = ui_scene.instantiate()

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		ui_label = ui_scene.instantiate()
		red_interact = true
		get_parent().add_child(ui_label)
		ui_label.global_position = $Sprite2D.global_position - Vector2(30,50)
		ui_label.modulate.a = 0
		var ui_tween = get_tree().create_tween()
		ui_tween.tween_property(ui_label,"modulate:a", 1, .5)

func _on_hitbox_body_exited(body):
	if body.is_in_group("player"):
		red_interact = false
		if is_instance_valid(ui_label):
			ui_label.despawn()

func talking():
	if is_instance_valid(ui_label):
		ui_label.despawn()
