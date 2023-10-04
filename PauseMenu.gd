extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_btn_pressed():
	get_tree().paused = not get_tree().paused
	$PauseMenu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_main_menu_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu.tscn")


func _on_exit_btn_pressed():
	get_tree().paused = false
	get_tree().quit()
	
func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer.visible = true
	
func unpause():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$VBoxContainer.visible = false
