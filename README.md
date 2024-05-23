# Game MVP 002

TODO (short description): https://www.udemy.com/course/create-a-procedurally-generated-2d-roguelike-in-godot-4/

- 8 Days of development
- Development start date: 2024-05-24
- MVP planned release date: 2024-06-01
- Name: TODO
- Learning goal: TODO
- Release link: TODO

## Gameplay overview

- TODO

## Controls

- Gamepad (preferred)
  - Left stick - move the player.
  - A - place a turret.
  - X - shoot.
  - Start - pause the game.
- Keyboard:
  - W, A, S, D - move the player.
  - Space - place a turret.
  - Enter - shoot.
  - Esc - pause the game.

## Gameplay details

- TODO

## Godot Guidelines

- Use push_error and push_warning for errors and warnings.
- Edotor Settings -> General -> Debug -> Auto Switch to Remote Scene Tree - ENABLE.
- Project Settings -> Display -> Window -> Always on Top - ENABLE.
- Use `Scene -> Save Branch As Scene` to simplify the scene and reuse it.
- Try to use less `@export` variables. Prioritize: local variables -> class variables -> exported variables.
- `Input.IsActionJustPressed(...)` (this frame only) для прыжка вместо `Input.IsActionPressed(...)`.
- Signal connections via code is better than via editor (UI) - it is more obvious.
- Use Debug Monitor for performance monitoring. It calls a callable object every second and writes int and float values.

## Files structure

The project is structured in a way that allows to easily reuse common scenes and tilesets across multiple projects. This approach will teach you to create convenient components for future games.

The structure is as follows:

```
- GodotProjectFoler
  - common (reusable scenes, tilesets)
	- tileset_[sqr|iso|hex]_<name> (reusable tileset)
	  - *.tres
	  - *.png
	- scene_<name> (reusable scene)
	  - *.tres
	  - *.gd
	  - *.tscn
	  - art/
		- *.png
		- *.mp3
	- sfx_<name> (reusable sound effect)
	  - art/
		- *.mp3
		- *.wav
	  - <name>_sfx.tres
  - this (game specific scenes, scripts and art)
	- main.tscn
	- main.gd
	- <name>.tscn
	- <name>.gd
	- art
	  - *.png
	  - *.mp3
	  - *.wav
```

**sqr** - square tileset.
**iso** - isometric tileset.
**hex** - hexagonal tileset.

## Devlog

- TODO

## Assets

- TODO

## Tools

- TODO
