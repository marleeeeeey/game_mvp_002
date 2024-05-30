extends Area2D

@export var amount = 2

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pick_ammo"):
		body.pick_ammo(amount)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
