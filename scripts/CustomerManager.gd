extends Node

const ERROR_MARGIN: float = 0.10
const AVIA_CARME = preload("uid://cb3ln805kbi7")
const CLIENT_2 = preload("uid://5lqc8deoay2i")

var customer_queue: Array[CustomerData] = [
	AVIA_CARME, CLIENT_2
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

func validate_player_number(number: int) -> int:
	if not current_customer:
		return false
	var target: int = current_customer.target_number
	print(number, ", ", (target * (1-ERROR_MARGIN)), ", ", (target * (1+ERROR_MARGIN)))
	if number < (target * (1-ERROR_MARGIN)):
		return -1
	elif number > (target * (1+ERROR_MARGIN)):
		return 1
	else: return 0
