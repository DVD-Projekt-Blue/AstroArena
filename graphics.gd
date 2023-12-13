extends Control

@onready var mode = $Menu/Options/ModeDropdown
@onready var antialiasing = $Menu/Options/MSAADropdown
@onready var vsync = $Menu/Options/VsyncCheck
@onready var resolution = $Menu/Options/ResolutionDropdown

var modeOptions = ["Fullscreen", "Borderless", "Windowed"]
var aaOptions = ["MSAAx2", "MSAAx4", "MSAAx8", "OFF"]
var resolutionOptions = ["Default", "800x600", "1280x720", "1366x768", "1600x900", "1920x1080", "2560x1440"]

# Called when the node enters the scene tree for the first time.
func _ready():
	mode.connect("item_selected", Callable(self, "on_mode_selected"))
	antialiasing.connect("item_selected", Callable(self, "_on_aa_dropdown_item_selected"))
	vsync.connect("toggled", Callable(self, "_on_vsync_check_toggled"))
	if resolution != null:resolution.connect("item_selected", Callable(self, "_on_resolution_dropdown_item_selected"))
	add_mode_items()
	add_aa_items()
	add_resolution_items()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_mode_items():
	for item in modeOptions:
		mode.add_item(item)

func add_aa_items():
	for item in aaOptions:
		antialiasing.add_item(item)

func add_resolution_items():
	for item in resolutionOptions:
		resolution.add_item(item)

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
	# Zde implementujte nastavení MSAA podle indexu
	pass

func _on_resolution_dropdown_item_selected(index):
	sif index == 0:
		# Nastavit defaultní rozlišení
		DisplayServer.window_set_size(Vector2(1920, 1080))
	else:
		# Získat šířku a výšku z vybraného rozlišení
		var resolutionArray = resolutionOptions[index].split("x")
		var width = int(resolutionArray[0])
		var height = int(resolutionArray[1])

		# Nastavit rozlišení
		DisplayServer.window_set_size(Vector2(width, height))

func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
