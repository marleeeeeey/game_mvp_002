extends Area2D


func _process(delta: float) -> void:
	# Hide cursor
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	# Set position of icon to cursor
	global_position = get_global_mouse_position()
