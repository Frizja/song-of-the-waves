extends TextureRect
@onready var Text = $Text
@onready var Triangle = $Triangle
var option = preload("res://Scenes/option.tscn")
var instances = []
var BubbleSize = 0
var say
var done = false
var changex = 0
var changey = 0
var endsWith
var options
var chosen_option = ""
var on_top = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_top:
		Triangle.flip_v = true
		Triangle.position.y = -11
	rotation = (0-get_parent().rotation)/1.2
	position.x += changex
	position.y += changey
	done = false
	while Input.is_action_pressed("Space"):
		await get_tree().process_frame
	get_parent().interacting = true
	Text.text = "[color=#000000]" + say
	Text.visible_characters = 0
	for i in say:
		Text.visible_characters += 1
		if !Input.is_action_pressed("Space"):
			await get_tree().create_timer(0.05).timeout
			while get_tree().paused:
				await get_tree().process_frame
	Text.visible_characters = -1
	if endsWith[0] != "_":
		Text.text = Text.text + "[color=#4adc80]\n [" + endsWith + "]"
		await  get_tree().create_timer(0.07).timeout
		while !(Input.is_action_just_pressed(endsWith)):
			await get_tree().process_frame
	elif endsWith == "_options":
		instances = []
		for i in options:
			instances.append(option.instantiate())
			add_child(instances[instances.size()-1])
			instances[instances.size()-1].text = i
			instances[instances.size()-1].position.y += instances.size()*40
			instances[instances.size()-1].position.x += 270
		var chosen = false
		while !chosen:
			for j in instances:
				if j.chosen:
					chosen = true
					chosen_option = j.text
					break
			await get_tree().process_frame
	get_parent().chosen = chosen_option
	get_parent().interacting  = false
	done = true
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	size.y += (BubbleSize-size.y)/2
	BubbleSize= Text.size.y + 20
	if !on_top:
		Triangle.position.y = BubbleSize
