class_name CustomerProgressBar
extends HBoxContainer

enum Difficulty { EASY, MEDIUM, HARD }

@export var difficulty_colors: Dictionary = {
	Difficulty.EASY: Color("#4ade80"),   # Green
	Difficulty.MEDIUM: Color("#facc15"), # Yellow
	Difficulty.HARD: Color("#f87171"),   # Red
}

@export var locked_dim_factor: float = 0.35
@export var completed_dim_factor: float = 0.7

var _segments: Array[Panel] = []

func _ready() -> void:
	_build_bar()

func _build_bar() -> void:
	for child in get_children():
		child.queue_free()
	_segments.clear()

	for i in CustomerManager.customer_queue:
		var segment := Panel.new()
		segment.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		segment.size_flags_vertical = Control.SIZE_EXPAND_FILL

		var style := StyleBoxFlat.new()
		style.set_corner_radius_all(3)
		segment.add_theme_stylebox_override("panel", style)

		add_child(segment)
		_segments.append(segment)
	print(_segments)

func _get_difficulty_color(index: int) -> Color:
	var current_customer: CustomerData = CustomerManager.customer_queue[index]
	if current_customer.stage_1 and current_customer.stage_2:
		return difficulty_colors.get(Difficulty.HARD, Color.WHITE)
	elif current_customer.stage_2:
		return difficulty_colors.get(Difficulty.MEDIUM, Color.WHITE)
	elif current_customer.stage_1:
		return difficulty_colors.get(Difficulty.EASY, Color.WHITE)
	else:
		printerr("THE CUSTOMER DOESN'T HVE ANY STAGE ASSIGNED")
		return Color.WHITE

func set_progress(current_level: int, is_current_completed: bool = false) -> void:
	for i in range(_segments.size()):
		var style := _segments[i].get_theme_stylebox("panel") as StyleBoxFlat
		var level_num := i + 1
		var base_color := _get_difficulty_color(i)

		if level_num < current_level or (level_num == current_level and is_current_completed):
			# Completed level: keep difficulty hue, slightly dimmed
			style.bg_color = base_color.darkened(1.0 - completed_dim_factor)
			style.border_width_left = 0
			style.border_width_right = 0
			style.border_width_top = 0
			style.border_width_bottom = 0
		elif level_num == current_level:
			# Active level: full difficulty color + crisp white highlight border
			style.bg_color = base_color
			style.border_color = Color.WHITE
			style.set_border_width_all(2)
		else:
			# Locked level: dimmed difficulty color so upcoming difficulty is still readable
			style.bg_color = base_color.darkened(1.0 - locked_dim_factor)
			style.border_width_left = 0
			style.border_width_right = 0
			style.border_width_top = 0
			style.border_width_bottom = 0
