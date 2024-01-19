extends Control

@onready var controls_button: Button = $PanelContainer/VBoxContainer/ControlsButton
@onready var graphics_button: Button = $PanelContainer/VBoxContainer/GraphicsButton
@onready var audio_button: Button = $PanelContainer/VBoxContainer/AudioButton
@onready var options_button: Button = $PanelContainer/VBoxContainer/OptionsButton
@onready var play_button: Button = $PanelContainer/VBoxContainer/PlayButton
@onready var exit_button: Button = $PanelContainer/VBoxContainer/ExitButton
@onready var background_music: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var hover_sound: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var click_sound: AudioStreamPlayer = AudioStreamPlayer.new()
@export var adress = "127.0.0.1"
@export var port = 8910

var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
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
	pass
	#if options_button.is_hovered() or audio_button.is_hovered() or graphics_button.is_hovered() or controls_button.is_hovered():
		#controls_button.visible = true
		#graphics_button.visible = true
		#audio_button.visible = true
	#else:
		#controls_button.visible = false
		#graphics_button.visible = false
		#audio_button.visible = false

func peer_connected(id):
	print("Player connected: " + str(id))
	
func peer_disconnected(id):
	print("Player disconnected: " + str(id))
	GameManager.Players.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()

func connected_to_server(id):
	print("Connection succesful!")
	send_player_information.rpc_id(1, "", multiplayer.get_unique_id())

func connection_failed(id):
	print("Connection failed!")
	
func host_game():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("cannot host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting For Players!")
	
@rpc("any_peer")
func send_player_information(name, id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] ={
			"name" : name,
			"id" : id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.Players:
			send_player_information.rpc(GameManager.Players[i].name, i)

@rpc("any_peer","call_local")
func start_game():
	#var scene = load("res://scenes/Level.tscn").instantiate()
	get_tree().change_scene_to_file("res://scenes/Level.tscn")
	#get_tree().root.add_child(scene)
	#self.hide()
	#background_music.stop()

func _on_play_button_pressed():
	start_game.rpc()
#	get_tree().change_scene_to_file("res://scenes/Level.tscn")

func _on_host_pressed():
	host_game()
	send_player_information("", multiplayer.get_unique_id())
	
func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(adress, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)	
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://scenes/controls.tscn")

func _on_graphics_pressed():
	get_tree().change_scene_to_file("res://scenes/graphics.tscn")

func _on_audio_pressed():
	get_tree().change_scene_to_file("res://scenes/audio.tscn")
	
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
