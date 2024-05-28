extends CharacterBody2D

# 1. Get direction in which we can go.
# 2. Apply force into this direction.
# 3. Shift the girection once again.

@export var fx_scene: PackedScene
@export var ammo_scene: PackedScene
@export var speed = 20

enum EnemyDirection { RIGHT, LEFT, UP, DOWN, CHASE }
var new_direction = EnemyDirection.RIGHT
var change_direction

# TODO: ???
@onready var target = get_node("../Player")

func _ready() -> void:
	choose_direction()


func _process(delta: float) -> void:
	match new_direction:
		EnemyDirection.RIGHT:
			move_right()
		EnemyDirection.LEFT:
			move_left()
		EnemyDirection.UP:
			move_up()
		EnemyDirection.DOWN:
			move_down()
		EnemyDirection.CHASE:
			chase_state()


func move_right():
	velocity = Vector2.RIGHT * speed
	$anim.play("move_right")
	move_and_slide()


func move_left():
	velocity = Vector2.LEFT * speed
	$anim.play("move_left")
	move_and_slide()


func move_up():
	velocity = Vector2.UP * speed
	$anim.play("move_up")
	move_and_slide()


func move_down():
	velocity = Vector2.DOWN * speed
	$anim.play("move_down")
	move_and_slide()


func choose_direction():
	change_direction = randi() % 4
	random_direction()


func random_direction():
	match change_direction:
		0:
			new_direction = EnemyDirection.RIGHT
		1:
			new_direction = EnemyDirection.LEFT
		2:
			new_direction = EnemyDirection.UP
		3:
			new_direction = EnemyDirection.DOWN


func _on_timer_timeout() -> void:
	choose_direction()
	$Timer.start()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		instance_fx()
		instance_ammo()
		queue_free()


func instance_fx():
	var fx = fx_scene.instantiate()
	fx.global_position = global_position
	get_tree().root.add_child(fx)


func instance_ammo():
	var ammo = ammo_scene.instantiate()
	ammo.global_position = global_position
	get_tree().root.add_child(ammo)


func chase_state():
	var chase_speed = 60
	velocity = position.direction_to(target.global_position) * chase_speed
	animation()
	move_and_slide()

func animation():
	if velocity > Vector2.ZERO:
		$anim.play("move_right")
	if velocity < Vector2.ZERO:
		$anim.play("move_left")


func _on_chase_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Follow"):
		new_direction = EnemyDirection.CHASE
