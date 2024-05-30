extends Area2D

signal on_player_exit

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		on_player_exit.emit()
