extends Node2D


func _ready() -> void:
	$anim.play("Active")
	$ExplosionSound.play()
	await get_tree().create_timer(0.6).timeout
