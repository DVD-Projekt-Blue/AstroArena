extends Node3D

@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = player.get_real_velocity()

	# Normalizujeme vektor pro získání pouze směru pohybu
	var direction = velocity.normalized()

	# Vytvoříme nový vektor ve směru pohybu a násobíme jeho délku 20
	var target_position = global_transform.origin + direction * 20

	# Použijeme metodu look_at k nastavení rotace objektu
#	look_at(target_position, Vector3(0, 1, 0))

	# Nastavíme novou pozici objektu ve vzdálenosti 20 od směru pohybu
	global_transform.origin = target_position
