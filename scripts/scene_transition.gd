class_name SceneTransition
extends CanvasLayer

@export var switch_duration: float = 1.0

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	color_rect.modulate.a = 0

func fade_in() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, 'modulate:a', 1, switch_duration / 2.0)
	await tween.finished

func fade_out() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, 'modulate:a', 0, switch_duration / 2.0)
	await tween.finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func load_scene(new_scene_file_path: String, params: Dictionary = {}) -> void:
	await fade_in()
	var new_scene = CustomLevelManager.load_level(new_scene_file_path)
	if new_scene.has_method("setup"):
		new_scene.setup(params)
	else: print("La escena ", new_scene, " no tiene la funcion setup.")
	await fade_out()
