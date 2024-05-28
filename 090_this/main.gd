extends Node2D

@export var player_scene: PackedScene
@export var exit_scene: PackedScene
@export var enemy_scene: PackedScene
@export var border := Rect2(1, 1, 140, 120)

var walker: WalkerAlgo = null
var step_history: Array = []
var ground_layer = 0  # Reference specific png in tilemap. 0 - is the first.

@onready var tilemap = $TileMap


func _ready() -> void:
	randomize()
	generate_level()
	$Timer.start()
	$GUI.set_timer_object($Timer)


func generate_level():
	walker = WalkerAlgo.new(Vector2(3, 2), border)
	step_history = walker.walk(1500)

	# List of empty cells.
	var using_cells: Array = []

	# Returns a Vector2i array with the positions of all cells containing a tile in the given layer.
	var all_cells: Array = tilemap.get_used_cells(ground_layer)

	# Clear step_history and destroy walker.
	tilemap.clear()
	walker.queue_free()

	for tile in all_cells:
		if !step_history.has(Vector2(tile.x, tile.y)):
			using_cells.append(tile)

	# Update all the cells in the cells coordinates array
	# so that they use the given terrain for the given terrain_set.
	tilemap.set_cells_terrain_connect(ground_layer, using_cells, ground_layer, ground_layer, false)
	tilemap.set_cells_terrain_path(ground_layer, using_cells, ground_layer, ground_layer, false)

	instance_player()
	instance_exit()
	instance_enemies()


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()


func instance_player():
	var player = player_scene.instantiate()
	add_child(player)
	# Spawn player in the first room.
	player.position = step_history.pop_front() * 16


func instance_exit():
	var exit = exit_scene.instantiate()
	add_child(exit)
	exit.position = walker.get_end_room().position * 16


func instance_enemies():
	for i in range(32):
		var enemy = enemy_scene.instantiate()
		enemy.position = (step_history.pick_random() * border.position) * 16
		add_child(enemy)


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
