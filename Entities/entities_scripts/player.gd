extends CharacterBody2D

var current_state = PlayerStates.MOVE
enum PlayerStates {MOVE, DEAD}
var is_dead = false

@onready var bullet_scene = preload("res://Entities/Scenes/Bullet/bullet_1.tscn")

@export var speed: int
var input_movement = Vector2()

@onready var gun = $gun_handler
@onready var gun_spr = $gun_handler/gun_sprite
@onready var bullet_point = $gun_handler/bullet_point
var pos
var rot


func _ready() -> void:
	pass  # Replace with function body.


func _process(delta: float) -> void:
	if PlayerData.health <= 0:
		current_state = PlayerStates.DEAD
	
	target_mouse()
	
	match current_state:
		PlayerStates.MOVE:
			movement(delta)
		PlayerStates.DEAD:
			dead()


func movement(delta):
	animations()

	# Return normalized vector
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_movement != Vector2.ZERO:
		velocity = input_movement * speed

	if input_movement == Vector2.ZERO:
		velocity = Vector2.ZERO

	if Input.is_action_just_pressed("ui_shoot"):
		PlayerData.ammo -= 1
		instance_bullet()

	move_and_slide()


func animations():
	if input_movement.length() == 0:
		$anim.play("Idle")
	else:
		$anim.play("Move")


func dead():
	is_dead = true
	velocity = Vector2.ZERO
	gun.visible = false
	$anim.play("Dead")
	# Wait end of animation
	await get_tree().create_timer($anim.current_animation_length).timeout
	if get_tree():
		get_tree().reload_current_scene()
		PlayerData.health += 4
		is_dead = false


func target_mouse():
	if is_dead == false:
		var mouse_movement = get_global_mouse_position()
		pos = global_position
		gun.look_at(mouse_movement)
		rot = rad_to_deg((mouse_movement - pos).angle())

		# Flip gun
		if rot >= -90 and rot <= 90:
			gun_spr.flip_v = false
			$Sprite2D.flip_h = false
		else:
			gun_spr.flip_v = true
			$Sprite2D.flip_h = true


func instance_bullet():
	var bullet = bullet_scene.instantiate()
	# Use global coordinates to calculate the direction
	bullet.direction = bullet_point.global_position - gun.global_position
	bullet.global_position = bullet_point.global_position
	get_tree().root.add_child(bullet)
	
	
func reset_states():
	current_state = PlayerStates.MOVE
