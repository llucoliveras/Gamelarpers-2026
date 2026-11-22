extends Node

const ERROR_MARGIN: float = 0.10
const PALLASSO_DIA_2 = preload("uid://b5rgh80sdtahf")
const PALLASSO_DIA_3 = preload("uid://c4eqprumavpr")

var customer_queue: Array[CustomerData] = [
	PALLASSO_DIA_2, PALLASSO_DIA_3
]
var current_index: int = 0

var current_customer: CustomerData = null

func get_next_customer() -> CustomerData:
	print(current_index, customer_queue)
	if current_index < customer_queue.size():
		current_customer = customer_queue[current_index]
		current_index += 1
		return current_customer
	else:
		current_customer = null
		return null # Fin de la cola / día completado

func validate_player_number(number: int = -1, target: int = -1) -> int:
	print(number, ", ", target)
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
