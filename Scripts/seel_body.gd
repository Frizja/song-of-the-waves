extends Sprite2D
@export var y_offset = 0
@export var swim_animated = false
var prev_position = Vector2(0,0)
func _ready() -> void:
	top_level = true
	while swim_animated:
		await get_tree().process_frame
		if position !=prev_position:
			prev_position= position
			frame_coords.x = 1
		else:
			frame_coords.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_parent().global_position
	position.y += y_offset
	#global_rotation += (get_parent().global_rotation - global_rotation)/10
	global_rotation = lerp_angle(global_rotation, get_parent().global_rotation, 10*delta)
