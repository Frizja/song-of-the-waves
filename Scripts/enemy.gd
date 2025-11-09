extends Area2D
@export var color = Color.ANTIQUE_WHITE
@export var rot = 0.0
@export var custom_path = false
@export var path_start:Vector2
@export var path_end:Vector2
@export var speed = -2
@export var sin_multiply = 10.0
@export var sin_divide = 20.0
@export var use_sin = false
@export var canHit = true
@export var animated = false
@export var minX = 195
@export var maxX = 945
@onready var sprite = $Sprite2D
var time = randf_range(0,1)
var SpeedX = 0
var SpeedY = 0
func _ready() -> void:
	if custom_path:
		position.x = path_start.x
		position.y = path_start.y



func _process(delta: float) -> void:
	rotate(rot*delta)
	sprite.self_modulate = color
	time += delta
	if use_sin:
		position.y += sin(position.x*sin_multiply)/sin_divide
	if time > 1/(abs(speed)+0.1):
		time = 0
		if animated:
			if get_child(1).frame == 0:
				get_child(1).frame = 1
			else:
				get_child(1).frame = 0
	if! custom_path:
		position.x += speed * delta * 50
		if position.x < minX:
			speed = abs(speed)
			get_child(1).flip_h = true
		if position.x > maxX:
			speed = abs(speed)*-1
			get_child(1).flip_h = false
	else:
		position.x += speed * delta * 50
		
		if speed/abs(speed) == -1 && abs(path_start.x - path_end.x) != 0:
			if (path_end.x < path_start.x):
				position.y += abs(path_start.y-path_end.y)/(abs(path_start.x - path_end.x)/abs(speed))
			else:
				position.y -= abs(path_start.y-path_end.y)/(abs(path_start.x - path_end.x)/abs(speed))

		elif abs(path_start.x - path_end.x) != 0:
			if (path_end.x < path_start.x):
				position.y -= abs(path_start.y-path_end.y)/(abs(path_start.x - path_end.x)/abs(speed))
			else:
				position.y += abs(path_start.y-path_end.y)/(abs(path_start.x - path_end.x)/abs(speed))
		
		# :((( This could defenitly have done better bu i didn't want to find a different solution (It works, so I will keep using it)
		if (position.x < path_end.x && path_end.x < path_start.x || position.x < path_start.x && path_start.x < path_end.x):
			speed = abs(speed)
			get_child(1).flip_h = true
		if (position.x > path_start.x && path_end.x < path_start.x) || (position.x > path_end.x && path_start.x < path_end.x):
			speed = abs(speed)*-1
			get_child(1).flip_h = false
	
	position.x += SpeedX * delta  * 50
	position.y += SpeedY * delta * 50
	SpeedY *= 0.9
	SpeedX *= 0.9
