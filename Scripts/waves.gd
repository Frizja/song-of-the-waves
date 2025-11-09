extends Line2D
var pos = Vector2(0,0)
var speed = 1
var a = 0
@export var len = 100

func _ready() -> void:
	pos = position
	for i in len:
		pos += Vector2.RIGHT*(10/(abs(a)+1))
		if not Input.is_action_pressed("ui_accept"):
			pos.y -= a  
			a += 1
		else:
			pos.y += a
			a +=  1
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_released("ui_accept"):
			a *=-1
		else:
			a*=0.7
		if a > 5:
			a = 5
		add_point(pos)
		await get_tree().process_frame
	var g = Gradient.new()
	g.remove_point(0)
	gradient = g
