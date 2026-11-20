extends Node2D

var quantitat_Xuixo = 1

# Referencias exactas a cada botón según tu estructura en el CanvasLayer
@onready var boton_plus: Button = $CanvasLayer/HBoxContainer/ButtonPlus
@onready var boton_less: Button = $CanvasLayer/HBoxContainer/ButtonLess

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Nos aseguramos de conectar por código cada botón a su función correcta
	boton_plus.pressed.connect(_al_pulsar_mas)
	boton_less.pressed.connect(_al_pulsar_menos)

func _al_pulsar_mas() -> void: 
	quantitat_Xuixo += 1
	print("¡Botón de SUMAR (+) pulsado! Xuxos totales: ", quantitat_Xuixo)

func _al_pulsar_menos() -> void: 
	# Evitamos que baje de 1 por seguridad (opcional, pero útil para el juego)
	if quantitat_Xuixo > 1:
		quantitat_Xuixo -= 1
	print("¡Botón de RESTAR (-) pulsado! Xuxos totales: ", quantitat_Xuixo)

func _on_button_pressed() -> void:
	pass # Replace with function body.
