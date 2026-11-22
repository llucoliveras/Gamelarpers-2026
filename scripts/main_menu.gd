extends CanvasLayer

@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayButton
@onready var exit_button: Button = $CenterContainer/VBoxContainer/ExitButton

const SHOP_SCENE = preload("uid://bsm4gt0efifqs")

var scene_transition: SceneTransition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.pressed.connect(_on_exit_button_pressed)
	play_button.pressed.connect(_on_play_button_pressed)

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene(SHOP_SCENE.resource_path)
