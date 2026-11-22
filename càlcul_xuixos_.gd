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
		
	# Configuramos los xuxos del contenedor al arrancar por seguridad
	preparar_contenedor_xuxos()
	
	# Forzamos la primera actualización visual
	actualizar_fase_dos()

# Función para asegurar que todos los huecos tienen textura y tamaño controlado
func preparar_contenedor_xuxos() -> void:
	if not contenedorXuixo:
		return
		
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
	var incremento = 1 * multiplicadorActual
	quantitatXuixo += incremento
	print("¡Botón (+) pulsado! Sumando ", incremento, ". Xuxos totales: ", quantitatXuixo)
	actualizar_fase_dos()

func _al_pulsar_menos() -> void: 
	var decremento = 1 * multiplicadorActual
	# Blindaje: nunca baja de 1
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

func _al_pulsar_guardar() -> void:
	print("--- GUARDANDO Y SALIENDO ---")
	print("Número final de xuxos enviados: ", quantitatXuixo)
	
	var parametrosResultado = {
		"quantitatXuixo": quantitatXuixo
	}
	# Aquí irá tu lógica de fundido (fade-in)

func actualizar_fase_dos() -> void:
	if quantitatXuixo < 1:
		quantitatXuixo = 1

	if contenedorXuixo:
		var hijos = contenedorXuixo.get_children()
		for i in range(hijos.size()):
			# Mostramos estrictamente desde 0 hasta la cantidad actual (tope 6)
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
			
	actualizar_fase_dos()



func _on_button_pressed() -> void:
	pass # Replace with function body.
