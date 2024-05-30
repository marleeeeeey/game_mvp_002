extends Node2D

const GAME_NAME = "CAVE ROGUELIKE"

@export var game_logic_scene: PackedScene
@export var pause_message_scene: PackedScene

# Create game_logic when game begin. Destroy at the end.
var game_logic: GameLogic = null
var pause_message = null

func _ready() -> void:
	# Init PauseMenu
	pause_message = pause_message_scene.instantiate()
	add_child(pause_message)
	
	# Loading level
	pause_message.show_text(GAME_NAME, "", "press space to start")
	reload_game_logic()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_message.show_text("PAUSE", "", "press Q to exit game")


func reload_game_logic():
	if game_logic:
		game_logic.queue_free()
	_create_game_logic()


func _on_game_over() -> void:
	pause_message.show_text("GAME OVER", GAME_NAME, "press space to start")
	reload_game_logic()


func on_level_complete():
	pause_message.show_text("LEVEL COMPLETE", GAME_NAME, "press space to start")
	reload_game_logic()


func _create_game_logic() -> void:
	game_logic = game_logic_scene.instantiate()
	add_child(game_logic)
	game_logic.on_game_over.connect(_on_game_over)
	game_logic.on_level_complete.connect(on_level_complete)
