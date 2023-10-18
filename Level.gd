extends Node3D

@onready var player = $"GU-97"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	
func _unhandled_input(event):
	pass
