extends Node2D

@onready var line_edit: LineEdit = $CanvasLayer/CenterContainer/VBoxContainer/LineEdit

var scene_transition: SceneTransition
var params

func setup(new_params: Dictionary) -> void:
	params = new_params

func _on_button_pressed() -> void:
	var value = int(line_edit.text)
	params.player_guess = value
	
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene("res://scenes/shop_scene.tscn", params)
