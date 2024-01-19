extends Control

var circularAreaRadius : float = 100.0 # Adjust the radius according to your needs

func _process(delta):
	# Get the global mouse position
	var mouse_position = get_global_mouse_position()
	
	# Calculate the distance from the center of the circular area
	var distance = mouse_position.distance_to(position + size / 2)
	
	# If the mouse is outside the circular area, confine it
	if distance > circularAreaRadius:
		# Calculate the direction from the center to the mouse
		var direction = (mouse_position - (position + size / 2)).normalized()
		
		# Move the mouse to the edge of the circular area
		var confined_position = (position + size / 2) + direction * circularAreaRadius
		set_global_position(confined_position)
