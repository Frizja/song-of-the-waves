extends Sprite2D
var instance
var interacting
var SpeechBubble = preload("res://Scenes/speech_bubble.tscn")
var chosen
var talked = 0
@onready var area = $Area2D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		await get_tree().process_frame
		if str(area.get_overlapping_areas()).contains("PlayerHitbox") and Input.is_action_just_pressed("Space"):
			for i in Global.Dialog[Global.lang]["Herera"]:
				say(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if str(area.get_overlapping_areas()).contains("PlayerHitbox"):
		label.show()
	else:
		label.hide()

func say(dialog:Array):
	while is_instance_valid(instance):
		await get_tree().process_frame
	interacting = true
	instance = SpeechBubble.instantiate()
	instance.say = dialog[0]
	instance.endsWith = dialog[1]
	if dialog[1] == "_options":
		instance.options = dialog[2]
	instance.changey = -200
	instance.changex = -50
	add_child(instance)
	while is_instance_valid(instance):
		await get_tree().process_frame
	interacting = false
