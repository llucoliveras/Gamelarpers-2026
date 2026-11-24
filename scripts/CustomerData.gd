class_name CustomerData
extends Resource

@export var id: int
@export var customer_name: String
@export var portrait: Texture2D
@export var target_mesure: int
@export var target_quantity: int
@export var target_image: Texture2D

# Rutas o títulos para el Dialogue Manager
@export var dialogue_entry: Resource 
@export var dialogue_error_lower_1: Resource
@export var dialogue_error_higher_1: Resource
@export var dialogue_error_lower_2: Resource
@export var dialogue_error_higher_2: Resource
@export var dialogue_exit: Resource

# Quines fases necesita el client
@export var stage_1: bool
@export var stage_2: bool
