extends Node2D

const TEST = preload("uid://dglunesu7aubi")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var scene_transition: SceneTransition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("animation ended ", anim_name)
	if anim_name == "shop_entry":
		DialogueManager.show_dialogue_balloon(TEST, "start")
		animation_player.play("idle")

func _on_dialogue_ended(dialogue):
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene("res://scenes/main_menu.tscn")
