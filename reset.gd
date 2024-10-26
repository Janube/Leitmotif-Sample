extends Label

func _ready():
	float_up()

func float_up():
	var ui_tween = create_tween()
	ui_tween.tween_property(self,"position", position + Vector2(0,4), 1).set_trans(Tween.TRANS_SINE)
	ui_tween.tween_callback(float_down)
	
func float_down():
	var ui_tween = create_tween()
	ui_tween.tween_property(self,"position", position + Vector2(0,-4), 1).set_trans(Tween.TRANS_SINE)
	ui_tween.tween_callback(float_up)
