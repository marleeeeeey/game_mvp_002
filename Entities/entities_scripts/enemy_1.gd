extends CharacterBody2D

# 1. Get direction in which we can go.
# 2. Apply force into this direction.
# 3. Shift the girection once again.

@export var speed = 20

enum EnemyDirection { RIGHT, LEFT, UP, DOWN }
var new_direction = EnemyDirection.RIGHT
var change_direction


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
	print(change_direction)
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
