extends Node
var player_pos = Vector2(0,0)
var Dialog = {}
var data_file_path = "res://Scripts/Dialog.json"
var chosen = {}
var lang = "en"
var already_seen_intro = false
var level = 1

func _ready() -> void:
	Dialog = load_json(data_file_path)

func load_json(path:String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsed = JSON.parse_string(dataFile.get_as_text())
		if parsed is Dictionary:
			return parsed
		else:
			print("Oh no! It seems as if the file " + path + " is not the right format! (Error Reading File)")
	else:
		print("Oh no! It seems as if the file " + path + " Does not exist :(")
