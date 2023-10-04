extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$PauseMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_just_pressed("menu"):
	#	get_tree().paused = not get_tree().paused
	#	if get_tree().paused:
	#		$PauseMenu.visible = true
	#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#	else:
	#		$PauseMenu.visible = false
	#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	#if event.is_action_pressed("ui_cancel"):
	#	$PauseMenu2.pause()
