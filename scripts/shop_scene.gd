extends Node2D

const TEST = preload("uid://dglunesu7aubi")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_node: Node2D = $Customer

var scene_transition: SceneTransition
var mesure_player_guess: int = -1
var quantity_player_guess: int = -1
var customer: CustomerData

func setup(params: Dictionary) -> void:
	if not params or (params and not params.customer):
		customer = CustomerManager.get_next_customer()
	else:
		customer = params.customer
		animation_player.play("idle")
		DialogueManager.show_dialogue_balloon(customer.dialogue_exit)
			
	if customer and customer.portrait:
		customer_node.change_sprite(customer.portrait)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("animation ended ", anim_name)
	match(anim_name):
		"shop_entry":
			DialogueManager.show_dialogue_balloon(customer.dialogue_entry)
			animation_player.play("idle")
		"shop_exit":
			customer = CustomerManager.get_next_customer()
			mesure_player_guess = -1
			if customer == null:
				_end_game()
			else:
				customer_node.change_sprite(customer.portrait)
				animation_player.play("shop_entry")

func _on_dialogue_ended(dialogue):
	if dialogue == customer.dialogue_entry:
		_load_stage()
	if dialogue == customer.dialogue_exit:
		animation_player.play("shop_exit")

func _load_stage():
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	var target_scene: String = ""
	if customer.stage_1:
		target_scene = "res://scenes/Phase1Mesure.tscn"
	elif customer.stage_2:
		target_scene = "res://CàlculXuixos_.tscn"
	if target_scene == "": 
		printerr("ALGUNA COSA HA ANAT MALAMANENT AL INTENTAR CARREGAR LA ESCENA DE L'STAGE")
		return
	scene_transition.load_scene(target_scene, {"customer": customer})
	
func _end_game():
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene("res://scenes/main_menu.tscn")
