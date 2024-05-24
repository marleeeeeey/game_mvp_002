extends CharacterBody2D

@export var speed: int
var input_movement = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)


func movement(delta):
	animations()
	
	# Return normalized vector
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		velocity = input_movement * speed
	
	if input_movement == Vector2.ZERO:
		velocity = Vector2.ZERO
		
	move_and_slide()


func animations():
	if input_movement != Vector2.ZERO:
		if input_movement.x > 0: 
			$anim.play("Move")
			$Sprite2D.flip_h = false
		if input_movement.x < 0: 
			$anim.play("Move")
			$Sprite2D.flip_h = true
	
	if input_movement == Vector2.ZERO:
		$anim.play("Idle")
