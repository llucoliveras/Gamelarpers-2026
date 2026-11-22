extends CanvasLayer

const MAIN_SCENE = preload("uid://dx6l740keq3vk")
@onready var timer: Timer = %Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene(MAIN_SCENE.resource_path)
