extends CharacterBody2D

@export var speed: int
var input_movement = Vector2()

@onready var gun = $gun_handler
@onready var gun_spr = $gun_handler/gun_sprite
@onready var bullet_point = $gun_handler/bullet_point
var pos
var rot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_mouse()
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


func target_mouse():
	var mouse_movement = get_global_mouse_position()
	pos = global_position
	gun.look_at(mouse_movement)
	rot = rad_to_deg((mouse_movement - pos).angle())
	
	if rot >= -90 and rot <= 90:
		gun_spr.flip_v = false
	else:
		gun_spr.flip_v = true
