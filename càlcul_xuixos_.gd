extends Node2D

# Variables de estado simplificadas
var quantitatXuixo = 1
var customer = null
var multiplicadorActual = 1

# Límite visual de xuxos configurado a 6
const LIMITE_VISUAL = 6

# Referencias a los botones usando el truco del camino único (%)
@onready var botonPlus: Button = %ButtonPlus
@onready var botonLess: Button = %ButtonLess
@onready var botonMultiplicador: TextureButton = %multiplicadorActual2
@onready var textoMultiplicador: Label = %TextoLabel

# Botón de Guardar
@onready var botonGuardar: Button = %Guardar

# Referencias a la estructura visual de la Fase 2
@onready var contenedorXuixo: HBoxContainer = %contenedor_xuixo
@onready var contadorBollitos: Label = %contador

func _ready() -> void:
	if botonPlus:
		botonPlus.pressed.connect(_al_pulsar_mas)
	if botonLess:
		botonLess.pressed.connect(_al_pulsar_menos)
	if botonMultiplicador:
		botonMultiplicador.pressed.connect(_al_pulsar_multiplicador)
	if botonGuardar:
		botonGuardar.pressed.connect(_al_pulsar_guardar)
	
	if textoMultiplicador:
		textoMultiplicador.text = "x" + str(multiplicadorActual)
		
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

# Función de guardado simplificada: solo empaqueta el dato y prepara el fade/transición
func _al_pulsar_guardar() -> void:
	print("--- GUARDANDO Y SALIENDO ---")
	print("Número final de xuxos a enviar: ", quantitatXuixo)
	
	# Diccionario ligero únicamente con lo necesario para la escena de diálogo
	var parametrosResultado = {
		"quantitatXuixo": quantitatXuixo
	}
	
	# TODO: Aquí puedes llamar a tu script de transición con fade (ej: SceneTransition.fade_to(...) )
	# pasándole 'parametrosResultado' para que la otra escena reciba el número de xuxos directamente.

# Lógica para mostrar las imágenes divididas (hasta 6) o activar el contador numérico
func actualizar_fase_dos() -> void:
	if contenedorXuixo:
		var hijos = contenedorXuixo.get_children()
		for i in range(hijos.size()):
			if i < quantitatXuixo and i < LIMITE_VISUAL:
				hijos[i].visible = true
			else:
				hijos[i].visible = false

	if contadorBollitos:
		contadorBollitos.text = "x " + str(quantitatXuixo)
		if quantitatXuixo > LIMITE_VISUAL:
			contadorBollitos.visible = true
		else:
			contadorBollitos.visible = false

func setup(parametros) -> void: 
	if parametros and parametros.customer: 
		customer = parametros.customer
		if customer.target_image: 
			%TextureRect.texture = customer.target_image

func _on_button_pressed() -> void:
	pass # Replace with function body.
