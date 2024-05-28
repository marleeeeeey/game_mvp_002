extends CanvasLayer

# Uses to calculate hearts position
const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

@onready var timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create all hearts in one place. Then they will be placed in process method.
	for i in PlayerData.health:
		# Create new sprite for new heart
		var new_heart = Sprite2D.new()
		# Copy heart options from original heart_icon
		new_heart.texture = $heart_icon.texture
		new_heart.hframes = $heart_icon.hframes
		$heart_icon.add_child(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ammo_amount.text = var_to_str(PlayerData.ammo)
	$timer_countdown.text = var_to_str(timer.time_left).pad_decimals(0)

	for heart in $heart_icon.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)

		var last_heart = floor(PlayerData.health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (PlayerData.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
