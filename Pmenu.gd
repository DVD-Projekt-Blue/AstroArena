extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("ContinueButton")
@onready var quit_button: Button = find_child("QuitButton")
@onready var main_menu_button: Button = find_child("MainMenuButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)
	main_menu_button.pressed.connect(onMainMenuButtonPressed)
	unpause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process(false)
	
func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process(true)

func onMainMenuButtonPressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
	
func _input(event):
	if event.is_action_pressed("menu"):
		if get_tree().paused:
			unpause()
		else:
			pause()
	
