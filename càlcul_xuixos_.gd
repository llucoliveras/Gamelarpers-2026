extends Node2D

const GENERIC_XUIXO_SIZE: int = 15

# Variables de estado (mínimo 1 xuxo siempre)
var quantitatXuixo = 1
var multiplicadorActual = 1
var params: Dictionary = {}

# Límite visual de xuxos configurado a 6
const LIMITE_VISUAL = 6

func _ready() -> void:
	%ButtonPlus.pressed.connect(_al_pulsar_mas)
	%ButtonMinus.pressed.connect(_al_pulsar_menos)
	%ButtonMultiplier.pressed.connect(_al_pulsar_multiplicador)
	%SaveButton.pressed.connect(_al_pulsar_guardar)
	
	%ButtonMultiplierLabel.text = "x" + str(multiplicadorActual)
		
	# Configuramos los xuxos del contenedor al arrancar por seguridad
	preparar_contenedor_xuxos()
	
	# Forzamos la primera actualización visual
	actualizar_fase_dos()

# Función para asegurar que todos los huecos tienen textura y tamaño controlado
func preparar_contenedor_xuxos() -> void:		
	var hijos = %XuixoContainer.get_children()
	if hijos.size() == 0:
		return
		
	# Pillamos la textura del primer xuxo como referencia principal
	var texturaBase = hijos[0].texture
	
	for hijo in hijos:
		if hijo is TextureRect:
			# Si duplicaste los nodos y olvidaron la textura, les ponemos la del primero
			if not hijo.texture and texturaBase:
				hijo.texture = texturaBase
				
			# Forzamos el modo de expansión para que las imágenes gigantes no rompan el diseño
			hijo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			# Tamaño fijo de cada xuxo en el contenedor (ajústalo a los píxeles que quieras)
			hijo.custom_minimum_size = Vector2(64, 64)

func _al_pulsar_mas() -> void: 
	quantitatXuixo += multiplicadorActual
	print("¡Botón (+) pulsado! Sumando ", multiplicadorActual, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_menos() -> void: 
	# Blindaje: nunca baja de 1
	quantitatXuixo = max(quantitatXuixo - multiplicadorActual, 1)	
	print("¡Botón (-) pulsado! Restando ", multiplicadorActual, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_multiplicador() -> void:
	multiplicadorActual *= 10
	if multiplicadorActual >= 1000:
		multiplicadorActual = 1
	
	print("¡Botón multiplicador presionado! Su valor actual es: x", multiplicadorActual)
	
	%ButtonMultiplierLabel.text = "x" + str(multiplicadorActual)

func _al_pulsar_guardar() -> void:
	var scene_transition = get_tree().current_scene.find_child("SceneTransition")
	if not scene_transition: return
	print(params)
	var target_quantity: int = params.customer.target_quantity
	var target_mesure: int = params.customer.target_mesure
	print(target_quantity, ", ", target_mesure)
	var custom_target: float = target_quantity / (target_mesure if target_mesure > 0 else GENERIC_XUIXO_SIZE) 
	var final_validation: int = CustomerManager.validate_player_number(quantitatXuixo, custom_target)
	match final_validation:
		0: scene_transition.load_scene("res://scenes/shop_scene.tscn", params)
		1: DialogueManager.show_dialogue_balloon(params.customer.dialogue_error_higher_2)
		-1: DialogueManager.show_dialogue_balloon(params.customer.dialogue_error_lower_2)

func actualizar_fase_dos() -> void:
	var hijos = %XuixoContainer.get_children()
	for i in range(hijos.size()):
		# Mostramos estrictamente desde 0 hasta la cantidad actual (tope 6)
		hijos[i].visible = i < quantitatXuixo and i < LIMITE_VISUAL

	%XuixoCounter.text = "x " + str(quantitatXuixo)
	%XuixoCounter.visible = quantitatXuixo > LIMITE_VISUAL

func setup(new_params) -> void: 
	if new_params:
		params = new_params
		if new_params.customer and new_params.customer.target_image:
			%TargetImage.texture = new_params.customer.target_image
			
	actualizar_fase_dos()
