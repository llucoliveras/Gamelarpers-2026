class_name CustomerData
extends Resource

@export var customer_name: String
@export var portrait: Texture2D
@export var target_number: int # El número que el jugador debe descubrir
@export var target_image: Texture2D

# Rutas o títulos para el Dialogue Manager
@export var dialogue_entry: Resource 
@export var dialogue_error_lower: Resource
@export var dialogue_error_higher: Resource
@export var dialogue_exit: Resource

# Quines fases necesita el client
@export var stage_1: bool
@export var stage_2: bool
