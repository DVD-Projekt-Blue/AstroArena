extends Control

@onready var mode = $Menu/Options/ModeDropdown
@onready var antialiasing = $Menu/Options/MSAADropdown
@onready var vsync = $Menu/Options/VsyncCheck

var modeOptions = ["Fullscreen", "Borderless", "Windowed"]
var aaOptions = ["MSAAx2", "MSAAx4", "MSAAx8", "OFF"]

# Called when the node enters the scene tree for the first time.
func _ready():
	mode.connect("item_selected", Callable(self, "on_mode_selected"))
	add_mode_items()
	add_aa_items()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_mode_items():
	for item in modeOptions:
		mode.add_item(item)
		
func add_aa_items():
	for item in aaOptions:
		antialiasing.add_item(item)

func on_mode_selected(id):
	pass

func _on_mode_dropdown_item_selected(index):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_vsync_check_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)




func _on_aa_dropdown_item_selected(index):
	if index == 1:
		get_viewport().msaa_3d and get_viewport().MSAA_2X
	else: if index == 2:
		get_viewport().msaa_3d and get_viewport().MSAA_4X
	else: if index == 3:
		get_viewport().msaa_3d and get_viewport().MSAA_8X

func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
