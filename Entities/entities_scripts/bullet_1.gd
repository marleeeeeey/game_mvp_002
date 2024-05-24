extends Area2D

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
	queue_free()


func _on_visible_screen_exited() -> void:
	queue_free()
