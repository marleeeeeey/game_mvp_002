extends CanvasLayer

# useful links:
# https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html
# https://www.youtube.com/watch?v=-4jVIKix-yk

var just_paused = true


func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	layer = 2  # on top of everything (0 is the lowest layer, 1 is the default layer for HUDs)


func _process(delta: float) -> void:
	# HACK: Skip the first frame after pausing because the pause action is still active
	if just_paused:
		$AnimationPlayer.play("start_pause")
		$PauseSfx.play()
		just_paused = false
		return

	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("start"):
		$PauseSfx.play()
		_end_pause()
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func show_text(centered_text, top_text = "", bottom_text = "") -> void:
	_clear_labels()
	$TopLabel.text = "{0}".format([top_text])
	$CenterLabel.text = "{0}".format([centered_text])
	$BottomLabel.text = "{0}".format([bottom_text])
	process_mode = Node.PROCESS_MODE_ALWAYS
	show()
	get_tree().paused = true


func _end_pause() -> void:
	$AnimationPlayer.play("end_pause")
	_clear_labels()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "end_pause":
		print("end pause")
		process_mode = Node.PROCESS_MODE_DISABLED
		get_tree().paused = false
		hide()
		just_paused = true


func _clear_labels() -> void:
	$TopLabel.text = ""
	$CenterLabel.text = ""
	$BottomLabel.text = ""
