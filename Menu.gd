extends Node2D

@onready var controls_button: Button = find_child("Controls")
@onready var graphics_button: Button = find_child("Graphics")
@onready var audio_button: Button = find_child("Audio")
@onready var options_button: Button = find_child("OptionsButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if options_button.is_hovered() or audio_button.is_hovered() or graphics_button.is_hovered() or controls_button.is_hovered():
		controls_button.visible = true;
		graphics_button.visible = true;
		audio_button.visible = true;
	else:
		controls_button.visible = false;
		graphics_button.visible = false;
		audio_button.visible = false;

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Level.tscn")


func _on_options_button_pressed():
	pass
	
	
func _on_exit_button_pressed():
	get_tree().quit()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://controls.tscn")

func _on_graphics_pressed():
	get_tree().change_scene_to_file("res://graphics.tscn")


func _on_audio_pressed():
	get_tree().change_scene_to_file("res://audio.tscn")
