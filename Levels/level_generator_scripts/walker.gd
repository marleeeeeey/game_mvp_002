extends Node
class_name WalkerRoom

# This script is about procedure generation of level as caves.
# It is called Wolker algorithm.
# https://www.udemy.com/course/create-a-procedurally-generated-2d-roguelike-in-godot-4/learn/lecture/42961552#overview
# TODO: https://www.youtube.com/watch?v=2nk6bJBTtlA
# So we are going to remove tiles in tilemap and generate rooms.
# Automapping(terrain) layer in tileset is used for correct visualisations.

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
var position = Vector2.ZERO # current position of digger (worker).
var direction = Vector2.RIGHT # direction of next movement (dig).
var borders = Rect2()
var step_history = []

var steps_since_turn = 0
var rooms = []

# Like a contructor in C++.
func _init(starting_position, new_borders) -> void:
	# Check that starting position is inside the borders.
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	
	
# Returns the list of vector for which we can go.
# steps (?) - number of steps which is used for digging (walking).
func walk(steps):
	# ???
	place_room(position)
	
	for step in steps:
		if steps_since_turn >= 7.5:
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history


func step():
	var taget_position = position + direction
	if borders.has_point(taget_position):
		steps_since_turn += 1
		position = taget_position
		# We a able to do next spep within out border
		return true 
	else:
		return false
	
# Change the direction of our worker. 
func change_direction():
	# ???
	place_room(position)
	
	steps_since_turn = 0
	# Make a variable copy of constant. Will modify it to generate random direction.
	var directions = DIRECTIONS.duplicate()
	# Remove the current direction. Because we want to a new random one.
	directions.erase(direction) 
	directions.shuffle()
	
	# Get and remove the front element from collection.
	direction = directions.pop_front()
	
	while not borders.has_point(position + direction):
		direction = directions.pop_front()
	

# Low level interface to create rooms.
func create_room(position, size):
	return {position = position, size = size}
	

# Create the room with center in position
func place_room(position):
	# Random the size of the room.
	var size = Vector2(randi() % 4 + 2, randi() % 4 + 2)
	# Floor is used to convert float to int.
	var top_left_corner = (position - size / 2).floor()
	
	rooms.append(create_room(position, size))

	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)


# Instance of the exit of level.
func get_end_room():
	var end_room = rooms.pop_back()
	var starting_position = step_history.front()
	
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
			
	return end_room
