extends Control

@onready var controls_button: Button = $OptionsButton/Controls
@onready var graphics_button: Button = $OptionsButton/Graphics
@onready var audio_button: Button = $OptionsButton/Audio
@onready var options_button: Button = $OptionsButton
@onready var play_button: Button = $PlayButton
@onready var exit_button: Button = $ExitButton
@onready var background_music: AudioStreamPlayer = AudioStreamPlayer.new()
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
	
	click_sound.stream = load("res://imports/sounds/click_sound_menu2.mp3")
	add_child(click_sound)

	background_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if options_button.is_hovered() or audio_button.is_hovered() or graphics_button.is_hovered() or controls_button.is_hovered():
		controls_button.visible = true
		graphics_button.visible = true
		audio_button.visible = true
	else:
		controls_button.visible = false
		graphics_button.visible = false
		audio_button.visible = false

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Level.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://controls.tscn")

func _on_graphics_pressed():
	get_tree().change_scene_to_file("res://graphics.tscn")

func _on_audio_pressed():
	get_tree().change_scene_to_file("res://audio.tscn")
	
var sound_played = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and (play_button.is_hovered() or exit_button.is_hovered() or controls_button.is_hovered() or graphics_button.is_hovered() or audio_button.is_hovered()):
		click_sound.play()

func _on_play_button_mouse_entered():
	click_sound.play()
func _on_options_button_mouse_entered():
	click_sound.play()
func _on_controls_mouse_entered():
	click_sound.play()
func _on_graphics_mouse_entered():
	click_sound.play()
func _on_audio_mouse_entered():
	click_sound.play()
func _on_exit_button_mouse_entered():
	click_sound.play()
