extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = false
		queue_free()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()
