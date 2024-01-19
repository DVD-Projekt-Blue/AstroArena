extends Node3D

@export var PlayerScene : PackedScene
#@onready var player = $"NavigationRegion3D/Kaito MCS-71"
@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var enemy_ship = preload("res://scenes/corvette.tscn") #předpřipravý objekt, který se spawne
var instance 

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	#get_tree().call_group("enemies", "update_target_location", currentPlayer.global_transform.origin)
	
func _unhandled_input(event):
	pass

#func _get_random_child(parent_node):
	#var random_id = randi() % parent_node.get_child_count()
	#return parent_node.get_child(random_id)


func _on_corvette_enemy_dead(): #funkce pro spawn
	#var spawn_point = _get_random_child(spawns).global_position
	await get_tree().create_timer(1).timeout #počká vteřinu, před spawnem
	var spawn_point = $Spawns.get_child(0).global_position #Vybere místo spawnu z nodů v nodu spawns ve scéně
	instance = enemy_ship.instantiate() #vytvoří instanci objektu ke spawnu
	instance.position = spawn_point #nastaví pozici spawnu
	navigation_region.add_child(instance) #přidá objekt do scény
