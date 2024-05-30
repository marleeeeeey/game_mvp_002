extends CharacterBody2D

signal on_player_died

enum PlayerStates { MOVE, DEAD }

@export var bullet_scene: PackedScene
@export var trail_scene: PackedScene
@export var speed: int

var input_movement = Vector2()
var current_state = PlayerStates.MOVE
var is_dead = false
var health = 4
var ammo = 5

@onready var gun = $gun_handler
@onready var gun_spr = $gun_handler/gun_sprite
@onready var bullet_point = $gun_handler/bullet_point


func _process(delta: float) -> void:
	if health <= 0:
		current_state = PlayerStates.DEAD

	target_mouse()
	joystick_mouse_controller(delta)

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

	if Input.is_action_just_pressed("ui_shoot") and ammo > 0:
		ammo -= 1
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
		health += 4
		is_dead = false
		on_player_died.emit()


func target_mouse():
	if is_dead == false:
		var mouse_movement = get_global_mouse_position()
		gun.look_at(mouse_movement)
		var rot = rad_to_deg((mouse_movement - global_position).angle())

		# Flip gun
		if rot >= -90 and rot <= 90:
			gun_spr.flip_v = false
			$Sprite2D.flip_h = false
		else:
			gun_spr.flip_v = true
			$Sprite2D.flip_h = true


# Control mouse via gamepad
func joystick_mouse_controller(delta):
	if is_dead == false:
		var mouse_sens = 2500.0
		var direction: Vector2
		var movement: Vector2

		direction = Input.get_vector("rs_left", "rs_right", "rs_up", "rs_down")

		if direction != Vector2.ZERO:
			# TODO: fix it. Use global_position of player to define cursor pos
			var viewport = get_viewport()
			var center = viewport.get_visible_rect().size / 2
			get_viewport().warp_mouse(center + direction.normalized() * 150)


func instance_bullet():
	var bullet = bullet_scene.instantiate()
	# Use global coordinates to calculate the direction
	bullet.direction = bullet_point.global_position - gun.global_position
	bullet.global_position = bullet_point.global_position
	get_tree().root.add_child(bullet)


func reset_states():
	current_state = PlayerStates.MOVE


func instance_trail():
	var trail = trail_scene.instantiate()
	trail.global_position = global_position
	get_tree().root.add_child(trail)


func _on_trail_timer_timeout() -> void:
	instance_trail()
	$trail_timer.start()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		flash()
		health -= 1


func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.5).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)


func pick_ammo(count: int):
	ammo += count
