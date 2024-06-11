# Game MVP 002 - Cave Roguelike

The game is implemented during the course "Create a Procedurally Generated 2D Roguelike in Godot 4" by Jean Vermeersch.
https://www.udemy.com/course/create-a-procedurally-generated-2d-roguelike-in-godot-4/

- 8 Days of development
- Development start date: 2024-05-24
- MVP planned release date: 2024-06-01
- Name: Cave Roguelike
- Learning goal: Learn how to generate levels procedurally.
- Release link: https://marleeeeeey.itch.io/cave-roguelike
- YouTube link: https://youtu.be/qk2FW4dJBd0

## Gameplay overview

- Player controls the character with a gun.
- Player kills enemies in procedurally generated levels.
- Player should find the exit to the next level in time.

## Controls

- Gamepad (preferred)
  - Left stick - move the player.
  - A - shoot.
  - Start - pause the game.
- Keyboard:
  - W, A, S, D - move the player.
  - Mouse - aim.
  - LMB - shoot.

## Godot Guidelines from Course

- Project Settings -> Display -> Window -> Always on Top - ENABLE.
- Save vieport size on rezising: Project Settings -> Display -> Window -> Stretch: Mode = Viewport, Aspect = Keep.
- Scene link is better to do via UI (drag and drop) instead of `preload`, bacause IDE will update paths if they change.
- Try to use less `@export` variables. Prioritize: local variables -> class variables -> exported variables.
- Use push_error and push_warning for errors and warnings.
- Use `Scene -> Save Branch As Scene` to simplify the scene and reuse it.
- `Input.IsActionJustPressed(...)` (this frame only) for jumping instead of `Input.IsActionPressed(...)`.
- Drug and drop scene elements to the script to create variables.
- `Help -> Search` or `F1` - to find the documentation for any class or method.
- Create small methods like `instance_bullet()`, `animations()`, `target_mouse()`.
- Use global coordinates (bullet.global_position) to simplify the calculations in the game.
- `get_tree().root` - to get The SceneTree's root Window.
- Use Node2D.ZIndex to set the order of rendering. 1 - top, -1 - bottom.
- Signature of contructor: `func _init(starting_position, new_borders) -> void:`.
- Instantiate class: `var bullet = Bullet.new()`.
- `randomize()` - to randomize the random number generator.
- `get_tree().reload_current_scene()` - to reload the current scene.
- Use groups (`Node -> Group -> Add`) for requesting/filtering nodes by group name.
- `get_tree().root.add_child(trail)` - set new object independent from the parent.
- `object.has_method("smash")` - to check if the object has a method.
- `self` - to refer to the current object.
- `lerp` - to interpolate between two values.

## Files structure

The project is structured in a way that allows to easily reuse common scenes and tilesets across multiple projects. This approach will teach you to create convenient components for future games.

The structure is as follows:

```
- GodotProjectFoler
  - 010_globals (keep link to the Camera2D, ...)
    - globals.gd
  - 015_scripts (reusable scripts without scenes)
    - *.gd
  - 017_standalone_tilesets (tilesets without dependencies)
    - <name>
      - *.tres
      - *.png
  - 020_standalone_scenes (scenes without dependencies)
    - <name>
      - *.tres
      - *.gd
      - *.tscn
      - art/
        - *.png
        - *.mp3
        - *.wav
  - 030_deps_scenes (scenes with dependencies from standalone scenes)
    - <name>
      - *.tres
      - *.gd
      - *.tscn
      - art/
        - *.png
        - *.mp3
        - *.wav
  - 090_this (game specific scenes, scripts and art)
    - main.tscn
    - main.gd
    - <name>.tscn
    - <name>.gd
    - art
      - *.png
      - *.mp3
      - *.wav
```

## Development Log

- Initial commit : #2024-05-24
- Import sprites and create the main scene : #2024-05-24
- Create the player with gun controlable by the mouse : #2024-05-24
- Player dead animation : #2024-05-25
- Initial GUI : #2024-05-26
- Prepare tileset for auto-tiling : #2024-05-26
- Create Walker algorithm for procedural generation : #2024-05-26
- Spawn player and exit icons : #2024-05-27
- Create second tilemap for the floor : #2024-05-27
- Create the enemy which is moved randomly : #2024-05-28
- Add exposion effect when the enemy is killed : #2024-05-28
- Add scent trail for the player. The enemy follows the scent trail : #2024-05-28
- Enemy catching the player with light animation : #2024-05-28
- Create camera shake effect when the player bullet hits : #2024-05-29
- Update GUI, add sound effects and music : #2024-05-28
- Refactoring: reusable scenes, remove global variables : #2024-05-29
- Final refactoring, docs : #2024-05-30
- Pause menu, game over screen : #2024-05-30
- Fast fix of gamepad control : #2024-05-30
- Public video to YouTube : #2024-05-30

## TODO list

- Improve gamepad control.
- Sound effects for dead.
- Randomness for the enemy movement.
- On game start player should spawn in safe place.

## Assets

- https://www.udemy.com/course/create-a-procedurally-generated-2d-roguelike-in-godot-4/

## Tools

- https://sfxr.me/ - SFXR Sound Generator

## Game Reviews

### Sergey Mazurov (telegram)

- It is almost "Hotline Miami"

### By DefinitlyNotABot (itch.io)

I played this game a few rounds and the gameplay and game mechanics are neat.

One thing I noticed is the time it takes to load after dying or winning. The game freezes for a short amount of time before the menu is displayed #TODO. For context, I played the browser version, not the one to download.

Another thing that happened was that a chicken got spawned right next to the player in one instance #TODO, so I instantly lost a heart. Maybe alter the spawn mechanic so the first room can't have a chicken.

Thirdly, and this is just my own opinion, it sometimes feels long to wander around aimlessly and randomly stumble into the goal. To change this, maybe you could add a gradient to the color #TODO, so it changes toward the goal. This would at least give some sort of direction. To combat the fact that this would make the game easier, you could increase the spawn rate of enemies the closer you get to the exit #TODO. To then still have the player explore the rest of the dungeon, maybe scatter around power-ups they can collect to have it easier on their way to the goal #TODO.
Having multiple types of enemies could also lead to a more interesting gameplay.

I see great potential in this game and I'd enjoy to see it grow

**Answer**

Thank you for review.
The first two comments are known issues.
Colored direction, encrease spawn-rate and power-ups are good ideas. I will think about it.

Currently I have a plan to publish a lot of MVPs in short time to learn. Now I switch from Godot to Unity. Here is the link to the next game: https://marleeeeeey.itch.io/delivery-driver.

My plan is create 10-15 MVPs in different engines and genres and then start a big project from scratch or continue one of the MVPs.

## My review of the course

This if my first course in Godot and I am very happy with it. Before that course I read the documentation and did my own game. But anyway I found a lot of new information about procedure generation, shaders, camera shaking, and other things.

But I would improve the following:
1. Name conventions for the variables, classes, items in game tree.
2. Use Input.get_vector everywhere if possible.
3. More strict about types in the code and using `: Type` for external variable to the script. It makes autocomplete better.
4. Add lectures about creating menus, dialogs, and settings.
