extends Node2D

const TEST = preload("uid://dglunesu7aubi")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_node: Node2D = $Customer

var scene_transition: SceneTransition
var player_guess: int = -1
var customer: CustomerData

func setup(params: Dictionary) -> void:
	if params and params.customer:
		customer = params.customer
	else:
		customer = CustomerManager.get_next_customer()
	if params and params.player_guess:
		player_guess = params.player_guess
		animation_player.play("idle")
		var is_correct_guess: int = CustomerManager.validate_player_number(player_guess)
		print(is_correct_guess)
		match is_correct_guess:
			0: DialogueManager.show_dialogue_balloon(customer.dialogue_exit)
			-1: DialogueManager.show_dialogue_balloon(customer.dialogue_error_lower)
			1: DialogueManager.show_dialogue_balloon(customer.dialogue_error_lower)
		
	if customer and customer.portrait:
		customer_node.change_sprite(customer.portrait)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("animation ended ", anim_name)
	if anim_name == "shop_entry":
		DialogueManager.show_dialogue_balloon(customer.dialogue_entry)
		animation_player.play("idle")

func _on_dialogue_ended(dialogue):
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene("res://scenes/temporary_scene.tscn", {"customer": customer})
