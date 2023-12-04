extends CharacterBody3D

const SPEED = 10.0
var health =  10

var player = null
#var next_nav_point = null
#var new_velocity = null

signal enemy_dead()

@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)
	
func _physics_process(delta):
	#velocity = Vector3.ZERO
	
	nav_agent.set_target_position(player.global_transform.origin)
	var current_location = global_transform.origin
	var next_nav_point = nav_agent.get_next_path_position()
	var new_velocity = (next_nav_point - current_location).normalized() * -SPEED
	
	velocity = new_velocity
	#move_and_slide()
	velocity = (next_nav_point - global_transform.origin).normalized() * -SPEED
	
	look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP  )
	
func update_target_location(target_location):
	nav_agent.target_position = target_location


func _on_area_3d_ship_hit(dam):
	health -= dam
	if health <= 0:
		await get_tree().create_timer(0.05).timeout
		queue_free()
		emit_signal("enemy_dead")
