extends Node2D

var quantitatXuixo = 1
var day = -1
var clienteActual = 1
var longitudTotal = 0.0
var longitudXuixo = 0.0
var xuixoObjetivo = 0.0
var tolerancia = 0.0

var multiplicadorActual = 1

# Referencias a los botones y al multiplicador
@onready var botonPlus: Button = $CanvasLayer/HBoxContainer/ButtonPlus
@onready var botonLess: Button = $CanvasLayer/HBoxContainer/ButtonLess
@onready var botonMultiplicador: TextureButton = $CanvasLayer/HBoxContainer2/multiplicadorActual2
@onready var textoMultiplicador: Label = $CanvasLayer/HBoxContainer2/multiplicadorActual2/TextoLabel

# Referencia al nuevo contador de bollitos (ajusta la ruta exacta si tu HBox contenedor tiene otro nombre)
@onready var contadorBollitos: Label = $CanvasLayer/VBoxContainer/HBoxContainer/contador

func _ready() -> void:
	if botonPlus:
		botonPlus.pressed.connect(_al_pulsar_mas)
	if botonLess:
		botonLess.pressed.connect(_al_pulsar_menos)
	
	if botonMultiplicador:
		botonMultiplicador.pressed.connect(_al_pulsar_multiplicador)
	
	if textoMultiplicador:
		textoMultiplicador.text = "x" + str(multiplicadorActual)
		
	# Actualizamos el texto del contador al iniciar la escena
	actualizar_contador_visual()

func _al_pulsar_mas() -> void: 
	var incremento = 1 * multiplicadorActual
	quantitatXuixo += incremento
	print("¡Botón (+) pulsado! Sumando ", incremento, ". Xuxos totales: ", quantitatXuixo)
	
	actualizar_contador_visual()

func _al_pulsar_menos() -> void: 
	var decremento = 1 * multiplicadorActual
	if quantitatXuixo - decremento >= 1:
		quantitatXuixo -= decremento
	else:
		quantitatXuixo = 1 
	print("¡Botón (-) pulsado! Restando ", decremento, ". Xuxos totales: ", quantitatXuixo)
	
	actualizar_contador_visual()

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

# Función para actualizar el texto del contador en pantalla
func actualizar_contador_visual() -> void:
	if contadorBollitos:
		# Si superamos los 10, mostramos el número exacto al lado del bollito
		contadorBollitos.text = "x " + str(quantitatXuixo)
		
		# Opcional: puedes hacer que el contador solo sea visible si hay más de 10, o dejarlo siempre visible
		if quantitatXuixo >= 10:
			contadorBollitos.visible = true
		else:
			contadorBollitos.visible = true # Cambia a false si prefieres que se oculte cuando son pocos

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
		
	# Actualizamos por si los parámetros traen un valor inicial de xuxos
	actualizar_contador_visual()

func _on_button_pressed() -> void:
	pass # Replace with function body.
