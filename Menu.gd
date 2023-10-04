extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Level.tscn")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
