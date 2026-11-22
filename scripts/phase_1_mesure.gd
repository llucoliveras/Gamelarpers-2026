extends Node2D

@onready var aspect_ratio_container: HBoxContainer = %AspectRatioContainer
@onready var object_image: TextureRect = %ObjectImage
@onready var h_slider: HSlider = %HSlider
@onready var save_button: Button = %SaveButton

var scene_transition: SceneTransition
var params: Dictionary
var max_container_width: float = 0.0

func setup(new_params: Dictionary) -> void:
	params = new_params

func _ready() -> void:
	h_slider.value_changed.connect(_on_h_slider_value_changed)
	
	var parent_max_size = aspect_ratio_container.custom_maximum_size
	var image_minimum_size = object_image.custom_minimum_size
	
	max_container_width = parent_max_size.x if parent_max_size.x > 0 else aspect_ratio_container.size.x
	# Avoid division by zero
	if max_container_width > 0:
		var proportion_of_total = (image_minimum_size.x * 100.0) / max_container_width
		h_slider.value = proportion_of_total

func _on_button_pressed() -> void:
	var value: float = h_slider.value
	
	var validation_result: int = CustomerManager.validate_player_number(value, params.customer.target_mesure)
	
	match(validation_result):
		0: successful_value()
		1: DialogueManager.show_dialogue_balloon(params.customer.dialogue_error_higher_1)
		-1: DialogueManager.show_dialogue_balloon(params.customer.dialogue_error_lower_1)

func successful_value() -> void:
	var next_scene: String = ""
	if params.customer and params.customer.stage_2:
		next_scene = "res://CàlculXuixos_.tscn"
	else:
		next_scene = "res://scenes/shop_scene.tscn"
	scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	scene_transition.load_scene(next_scene, params)

func _on_h_slider_value_changed(value: float) -> void:
	# Ensure we have a valid width to scale against
	if max_container_width <= 0:
		max_container_width = aspect_ratio_container.size.x
		if max_container_width <= 0: return
	
	var percentage = value / h_slider.max_value
	
	# Adjust the image's minimum horizontal width based on the percentage of the container
	object_image.custom_minimum_size.x = max_container_width * percentage
