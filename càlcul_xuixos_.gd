extends Node2D

# Variables de estado (mínimo 1 xuxo siempre)
var quantitatXuixo = 1
var customer = null
var multiplicadorActual = 1

# Límite visual de xuxos configurado a 6
const LIMITE_VISUAL = 6

# Referencias a los botones usando nombres únicos (%)
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
	botonPlus.pressed.connect(_al_pulsar_mas)
	botonLess.pressed.connect(_al_pulsar_menos)
	botonMultiplicador.pressed.connect(_al_pulsar_multiplicador)
	botonGuardar.pressed.connect(_al_pulsar_guardar)
	
	textoMultiplicador.text = "x" + str(multiplicadorActual)
		
	# Configuramos los xuxos del contenedor al arrancar por seguridad
	preparar_contenedor_xuxos()
	
	# Forzamos la primera actualización visual
	actualizar_fase_dos()

# Función para asegurar que todos los huecos tienen textura y tamaño controlado
func preparar_contenedor_xuxos() -> void:		
	var hijos = contenedorXuixo.get_children()
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
	quantitatXuixo = max(quantitatXuixo - multiplicadorActual, 1)
	print("¡Botón (-) pulsado! Restando ", multiplicadorActual, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_multiplicador() -> void:
	multiplicadorActual *= 10
	if multiplicadorActual >= 1000:
		multiplicadorActual = 1
	
	print("¡Botón multiplicador presionado! Su valor actual es: x", multiplicadorActual)
	
	textoMultiplicador.text = "x" + str(multiplicadorActual)

func _al_pulsar_guardar() -> void:
	print("--- GUARDANDO Y SALIENDO ---")
	print("Número final de xuxos enviados: ", quantitatXuixo)
	
	var parametrosResultado = {
		"quantitatXuixo": quantitatXuixo
	}
	# Aquí irá tu lógica de fundido (fade-in)

func actualizar_fase_dos() -> void:
	var hijos = contenedorXuixo.get_children()
	for i in range(hijos.size()):
		# Mostramos estrictamente desde 0 hasta la cantidad actual (tope 6)
		hijos[i].visible = i < quantitatXuixo and i < LIMITE_VISUAL

	contadorBollitos.text = "x " + str(quantitatXuixo)
	contadorBollitos.visible = quantitatXuixo > LIMITE_VISUAL

func setup(parametros) -> void: 
	if parametros and parametros.customer: 
		customer = parametros.customer
		if customer.target_image: 
			%TextureRect.texture = customer.target_image
			
	actualizar_fase_dos()
