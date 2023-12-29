extends Node3D

const SPEED = 400

var velocity = Vector3(0, 0, -SPEED)

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		velocity = Vector3(0, 0, 0)
		ray.enabled = false
		if ray.get_collider().is_in_group("enemy"):
			ray.get_collider().hit()
		await get_tree().create_timer(1.0).timeout
	else:
		position += transform.basis * velocity * delta
		

func _on_timer_timeout():
	queue_free()
