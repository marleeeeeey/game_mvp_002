extends Node2D


@onready var tilemap = $TileMap
@export var border = Rect2(1, 1, 140, 120)
var walker
var map

var ground_layer = 0 # Reference specific png in tilemap. 0 - is the first.

func _ready() -> void:
	randomize()
	generate_level()


func generate_level():
	walker = WalkerRoom.new(Vector2(3, 2), border)
	map = walker.walk(1500)

	# List of empty cells.
	var using_cells: Array = []
	
	# Returns a Vector2i array with the positions of all cells containing a tile in the given layer. 
	var all_cells: Array = tilemap.get_used_cells(ground_layer)
	
	# Clear map and destroy walker.
	tilemap.clear()
	walker.queue_free()
	
	for tile in all_cells:
		if !map.has(Vector2(tile.x, tile.y)):
			using_cells.append(tile)
	
	# Update all the cells in the cells coordinates array 
	# so that they use the given terrain for the given terrain_set.
	tilemap.set_cells_terrain_connect(ground_layer, using_cells, ground_layer, ground_layer, false)
	tilemap.set_cells_terrain_path(ground_layer, using_cells, ground_layer, ground_layer, false)


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
