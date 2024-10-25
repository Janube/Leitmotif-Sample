extends Node2D
@onready var red_scene = preload("red.tscn")
@onready var yellow_scene = preload("yellow.tscn")
@onready var grey_scene = preload("grey.tscn")
@onready var red_spawn = false
@onready var yellow_spawn = false
@onready var grey_spawn = false
@onready var start = true
@onready var talking = false
@onready var default_tween
@onready var red_tween
@onready var blue_tween
@onready var yellow_tween
@onready var grey_tween


func ready():
	await get_tree().create_timer(1.0).timeout
	
func _process(_delta):
	pass
	#if start == true:
		#ost()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("interact") and $"Red Sign".red_interact == true and talking == false:
		red_event()
	if event.is_action_pressed("interact") and $"Blue Sign".blue_interact == true and talking == false:
		blue_event()
	if event.is_action_pressed("interact") and $"Yellow Sign".yellow_interact == true and talking == false:
		yellow_event()
	if event.is_action_pressed("interact") and $"Grey Sign".grey_interact == true and talking == false:
		grey_event()

func red_event():
	$"Red Sign".talking()
	talking = true
	$"CAT!".dialogue()
	red_tween = get_tree().create_tween()
	red_tween.tween_property($Default,"volume_db", -60, 1)
	$Red.play()
	$Red.volume_db = -60
	red_tween.tween_property($Red,"volume_db", 0, 1)
	if red_spawn == false:
		var red = red_scene.instantiate()
		get_parent().add_child(red)
		red.position.x = $"CAT!".global_position.x + 40
		red.position.y = $"CAT!".global_position.y - 320
		await get_tree().create_timer(4).timeout
	Dialogic.start("Red")
	red_spawn = true
	
func blue_event():
	$"Blue Sign".talking()
	$Blue2/Sprite2D.scale.x = 1
	talking = true
	$"CAT!".dialogue()
	blue_tween = get_tree().create_tween()
	blue_tween.tween_property($Default,"volume_db", -60, 1)
	$Blue.play()
	$Blue.volume_db = -60
	blue_tween.tween_property($Blue,"volume_db", 0, 1)
	Dialogic.start("Blue")
	
func yellow_event():
	$"Yellow Sign".talking()
	talking = true
	$"CAT!".dialogue()
	yellow_tween = get_tree().create_tween()
	yellow_tween.tween_property($Default,"volume_db", -60, 1)
	$Yellow.play()
	$Yellow.volume_db = -60
	yellow_tween.tween_property($Yellow,"volume_db", 0, 1)
	if yellow_spawn == false:
		var yellow = yellow_scene.instantiate()
		get_parent().add_child(yellow)
		yellow.position.x = $"CAT!".global_position.x + 150
		yellow.position.y = $"CAT!".global_position.y
		#yellow.position += ($"CAT!".global_position - yellow.position).normalized()
		#yellow_tween.tween_property(yellow,"position", $"CAT!".global_position + Vector2(40,0), 4)
		await get_tree().create_timer(3.7).timeout
		yellow.done_spawning()
	Dialogic.start("Yellow")
	yellow_spawn = true


func grey_event():
	$"Grey Sign".talking()
	talking = true
	$"CAT!".dialogue()
	grey_tween = get_tree().create_tween()
	grey_tween.tween_property($Default,"volume_db", -60, 1)
	$Grey.play()
	$Grey.volume_db = -60
	grey_tween.tween_property($Grey,"volume_db", 0, 1)
	if grey_spawn == false:
		var grey = grey_scene.instantiate()
		get_parent().add_child(grey)
		grey.position.x = $"CAT!".global_position.x + 30
		grey.position.y = $"CAT!".global_position.y + 10
		grey.modulate.a = 0
		grey.modulate.r = 0
		grey.modulate.b = 0
		grey_tween.tween_property(grey,"modulate:a", 1, 2)
		grey_tween.parallel().tween_property(grey,"modulate:r", 1, 2)
		grey_tween.parallel().tween_property(grey,"modulate:b", 1, 2)
		grey_tween.parallel().tween_property(grey,"position:x", $"CAT!".global_position.x + 50, 2)
		#yellow.position += ($"CAT!".global_position - yellow.position).normalized()
		#yellow_tween.tween_property(yellow,"position", $"CAT!".global_position + Vector2(40,0), 4)
		await get_tree().create_timer(3.7).timeout
		grey.done_spawning()
	Dialogic.start("Grey")
	grey_spawn = true

func done_talking():
	red_tween = get_tree().create_tween()
	red_tween.tween_property($Red,"volume_db", -60, 1)
	$Red.stop()
	blue_tween = get_tree().create_tween()
	blue_tween.tween_property($Blue,"volume_db", -60, 1)
	$Blue.stop()
	yellow_tween = get_tree().create_tween()
	yellow_tween.tween_property($Yellow,"volume_db", -60, 1)
	$Yellow.stop()
	grey_tween = get_tree().create_tween()
	grey_tween.tween_property($Grey,"volume_db", -60, 1)
	$Grey.stop()
	talking = false
	ost()
	
func ost():
	default_tween = get_tree().create_tween()
	$Default.volume_db = -60
	$Default.play()
	default_tween.tween_property($Default,"volume_db", -20, 1)
	#start = false
