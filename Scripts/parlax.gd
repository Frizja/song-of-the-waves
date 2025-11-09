extends Sprite2D
@export var strength = 1.0
var start_pos
var started
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = position
	started = true


func _process(delta: float) -> void:
	if started:
		position = start_pos - Global.player_pos/strength
