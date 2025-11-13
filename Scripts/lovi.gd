extends Sprite2D
var instance
var interacting
var SpeechBubble = preload("res://Scenes/speech_bubble.tscn")
var chosen
var talked = 0
var quest = false
@onready var area = $Area2D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		await get_tree().process_frame
		if str(area.get_overlapping_areas()).contains("PlayerHitbox") and Input.is_action_just_pressed("Space"):
			if !quest and talked == 0:
				talked += 1
				for i in Global.Dialog[Global.lang]["Lovi"]:
					say(i)
				while str(area.get_overlapping_areas()).contains("PlayerHitbox"):
					await get_tree().process_frame
				talked += 1
			elif talked == 2:
				talked += 1
				for i in Global.Dialog[Global.lang]["Lovi2"]:
					chosen = ""
					say(i)
				while chosen == "" or interacting:
					await get_tree().process_frame
				quest = !(chosen.contains("No") or chosen.contains("no"))
				if quest:
					Global.talked_to.append("Lovi")
				for i in Global.Dialog[Global.lang]["Lovi"+chosen]:
					say(i)
			elif quest:
				if Global.Jellyfish == 3:
					for i in Global.Dialog[Global.lang]["LoviDone"]:
						say(i)
					while interacting:
						await get_tree().process_frame
					Global.items.append("Shell Shield")
					queue_free()
				else:
					for i in Global.Dialog[Global.lang]["LoviWaiting"]:
						say(i)
					while str(area.get_overlapping_areas()).contains("PlayerHitbox"):
						await get_tree().process_frame

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
	instance.changey = -150
	instance.changex = -50
	add_child(instance)
	while is_instance_valid(instance):
		await get_tree().process_frame
	interacting = false
