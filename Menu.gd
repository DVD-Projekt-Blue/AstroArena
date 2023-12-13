extends Node2D

@onready var controls_button: Button = find_child("Controls")
@onready var graphics_button: Button = find_child("Graphics")
@onready var audio_button: Button = find_child("Audio")
@onready var options_button: Button = find_child("OptionsButton")

# Add an AudioStreamPlayer for background music
@onready var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

# Add AudioStreamPlayer nodes for hover and click sounds
@onready var hover_sound: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var click_sound: AudioStreamPlayer = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load the background music
	background_music.stream = load("res://imports/sounds/main_menu.mp3")
	add_child(background_music)
	
	# Load hover and click sounds
	hover_sound.stream = load("res://imports/sounds/hover_menu_sound.mp3")
	add_child(hover_sound)
	
	click_sound.stream = load("res://imports/sounds/click_sound_menu.mp3")
	add_child(click_sound)

	# Uncomment the line below if you want the music to loop
	# background_music.loop = true

	# Uncomment the line below if you want the music to play when the scene starts
	background_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if options_button.is_hovered() or audio_button.is_hovered() or graphics_button.is_hovered() or controls_button.is_hovered():
		controls_button.visible = true
		graphics_button.visible = true
		audio_button.visible = true
		hover_sound.play()
	else:
		controls_button.visible = false
		graphics_button.visible = false
		audio_button.visible = false

func _on_play_button_pressed():
	click_sound.play()
	get_tree().change_scene_to_file("res://Level.tscn")

func _on_options_button_pressed():
	click_sound.play()
	# Add logic for options button press

func _on_exit_button_pressed():
	click_sound.play()
	get_tree().quit()

func _on_controls_pressed():
	click_sound.play()
	get_tree().change_scene_to_file("res://controls.tscn")

func _on_graphics_pressed():
	click_sound.play()
	get_tree().change_scene_to_file("res://graphics.tscn")

func _on_audio_pressed():
	click_sound.play()
	get_tree().change_scene_to_file("res://audio.tscn")
