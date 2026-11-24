extends Node

const ERROR_MARGIN: float = 0.10

const INFORMATICO = preload("uid://b3fbspti12l4s")
const AVIA = preload("uid://cdl3fhlhrydu3")
const JOHN_QUOK = preload("uid://beau74kk8d4l2")
const DAFNE = preload("uid://c5myabb1222v6")
const HOMBRE_PURPURA = preload("uid://1iemhcbafh8q")
const PALLASSO_DIA_2 = preload("uid://b5rgh80sdtahf")
const PEPE = preload("uid://caavsh2ib217x")
const RATA = preload("uid://b32ycbbrjyxy3")
const PALLASSO_DIA_3 = preload("uid://c4eqprumavpr")
const AVIA_DIA_3 = preload("uid://cwt42aggshphm")
const JOHN_QUOKDIA_3 = preload("uid://cp7bil4g5kaop")
const INFORMATICO_DIA_3 = preload("uid://dk4psvbaubo2d")

var customer_queue: Array[CustomerData] = [
	INFORMATICO,
	AVIA,
	JOHN_QUOK,
	DAFNE,
	HOMBRE_PURPURA,
	PALLASSO_DIA_2,
	PEPE,
	RATA,
	PALLASSO_DIA_3,
	AVIA_DIA_3,
	JOHN_QUOKDIA_3,
	INFORMATICO_DIA_3
]
var current_index: int = 0

var current_customer: CustomerData = null

func get_next_customer() -> CustomerData:
	if current_index < customer_queue.size():
		current_customer = customer_queue[current_index]
		current_index += 1
		return current_customer
	else:
		current_customer = null
		return null # Fin de la cola / día completado

func validate_player_number(number: float = -1, target: float = -1) -> int:
	if not current_customer:
		return -999
		
	if number < (target * (1-ERROR_MARGIN)):
		return -1
	elif number > (target * (1+ERROR_MARGIN)):
		return 1
	else: return 0
	

func _is_number_in_target_error_margin(number: float, target: float) -> bool:
	if number < (target * (1-ERROR_MARGIN)):
		return -1
	elif number > (target * (1+ERROR_MARGIN)):
		return 1
	else: return 0
