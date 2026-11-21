extends Node2D

@onready var line_edit: LineEdit = $CanvasLayer/CenterContainer/VBoxContainer/LineEdit

var scene_transition: SceneTransition
var params

func setup(new_params: Dictionary) -> void:
	params = new_params

func _on_button_pressed() -> void:
	var value = float(line_edit.text)
	params.mesure_player_guess = value
	
	var next_scene: String = ""
	if params.customer and params.customer.stage_2:
		next_scene = "res://CàlculXuixos_.tscn"
	else:
		next_scene = "res://scenes/shop_scene.tscn"
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene("res://scenes/shop_scene.tscn", params)
