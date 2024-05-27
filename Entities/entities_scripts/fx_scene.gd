extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$anim.play("Active")
	await  get_tree().create_timer(0.6).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
