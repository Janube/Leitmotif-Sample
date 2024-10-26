extends CharacterBody2D

	
func _process(_delta):
	pass

func despawn():
	var ui_tween = create_tween()
	ui_tween.tween_property($Label,"modulate:a", 0, .5)
	await ui_tween.finished
	queue_free()
