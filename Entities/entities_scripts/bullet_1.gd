extends Area2D

@export var fx_scene: PackedScene
@export var speed = 50
var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move the bullet
	translate(direction * speed * delta)


func _on_body_entered(body: Node2D) -> void:
	Globals.camera.screen_shake(5, 5, 0.05)
	instance_fx()
	queue_free()


func _on_visible_screen_exited() -> void:
	queue_free()

func instance_fx():
	var fx = fx_scene.instantiate()
	fx.global_position = global_position
	get_tree().root.add_child(fx)
