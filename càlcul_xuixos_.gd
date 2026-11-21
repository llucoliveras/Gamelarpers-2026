extends Node2D

# Variables definidas con la segunda palabra en mayúscula
var quantitatXuixo = 1
var day = -1
var clienteActual = 1
var longitudTotal = 0.0
var longitudXuixo = 0.0
var xuixoObjetivo = 0.0
var tolerancia = 0.0

var multiplicadorActual = 1

# Límite visual estricto de xuxos en el contenedor (10)
const LIMITE_VISUAL = 6

# Referencias a los botones principales
@onready var botonPlus: Button = $CanvasLayer/HBoxContainer/ButtonPlus
@onready var botonLess: Button = $CanvasLayer/HBoxContainer/ButtonLess
@onready var botonMultiplicador: TextureButton = $CanvasLayer/HBoxContainer2/multiplicadorActual2
@onready var textoMultiplicador: Label = $CanvasLayer/HBoxContainer2/multiplicadorActual2/TextoLabel

# Referencias exactas a tu nueva estructura visual de la Fase 2
@onready var contenedorXuixo: HBoxContainer = $CanvasLayer/VBoxContainer/HBoxContainer/contenedor_xuixo
@onready var contadorBollitos: Label = $CanvasLayer/VBoxContainer/HBoxContainer/contador

func _ready() -> void:
	# Conexión de botones
	if botonPlus:
		botonPlus.pressed.connect(_al_pulsar_mas)
	if botonLess:
		botonLess.pressed.connect(_al_pulsar_menos)
	if botonMultiplicador:
		botonMultiplicador.pressed.connect(_al_pulsar_multiplicador)
	
	if textoMultiplicador:
		textoMultiplicador.text = "x" + str(multiplicadorActual)
		
	# Inicializamos la vista de la fase 2
	actualizar_fase_dos()

func _al_pulsar_mas() -> void: 
	var incremento = 1 * multiplicadorActual
	quantitatXuixo += incremento
	print("¡Botón (+) pulsado! Sumando ", incremento, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_menos() -> void: 
	var decremento = 1 * multiplicadorActual
	if quantitatXuixo - decremento >= 1:
		quantitatXuixo -= decremento
	else:
		quantitatXuixo = 1 
	print("¡Botón (-) pulsado! Restando ", decremento, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_multiplicador() -> void:
	if multiplicadorActual == 1:
		multiplicadorActual = 10
	elif multiplicadorActual == 10:
		multiplicadorActual = 100
	else:
		multiplicadorActual = 1
	
	print("¡Botón multiplicador presionado! Su valor actual es: x", multiplicadorActual)
	
	if textoMultiplicador:
		textoMultiplicador.text = "x" + str(multiplicadorActual)

# Lógica inteligente para mostrar las imágenes divididas o el contador
func actualizar_fase_dos() -> void:
	# 1. Gestionar las 10 imágenes dentro de contenedor_xuixo
	if contenedorXuixo:
		var hijos = contenedorXuixo.get_children()
		for i in range(hijos.size()):
			# Si la cantidad actual cubre este índice (y no pasamos de 10), se muestra
			if i < quantitatXuixo and i < LIMITE_VISUAL:
				hijos[i].visible = true
			else:
				# Si sobra o superamos los 10, se oculta para congelar el tamaño visual mínimo
				hijos[i].visible = false

	# 2. Gestionar el contador numérico de al lado
	if contadorBollitos:
		contadorBollitos.text = "x " + str(quantitatXuixo)
		
		# El contador se muestra solo si pasamos de 10 (o puedes dejarlo siempre visible si prefieres)
		if quantitatXuixo > LIMITE_VISUAL:
			contadorBollitos.visible = true
		else:
			contadorBollitos.visible = false

func setup(parametros) -> void: 
	if parametros.has("day") and parametros.day: 
		day = parametros.day
	if parametros.has("clienteActual") and parametros.clienteActual:
		clienteActual = parametros.clienteActual
	if parametros.has("longitudTotal") and parametros.longitudTotal:
		longitudTotal = parametros.longitudTotal
	if parametros.has("xuixoObjetivo") and parametros.xuixoObjetivo:
		xuixoObjetivo = parametros.xuixoObjetivo
	if parametros.has("tolerancia") and parametros.tolerancia:
		tolerancia = parametros.tolerancia
		
	actualizar_fase_dos()

func _on_button_pressed() -> void:
	pass # Replace with function body.
