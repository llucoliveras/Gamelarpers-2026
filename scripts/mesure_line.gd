@tool # This allows the ruler to update visually right inside the editor!
extends Node2D

@export var start_point: Vector2 = Vector2(100, 100):
	set(val):
		start_point = val
		queue_redraw()
		
@export var end_point: Vector2 = Vector2(700, 100):
	set(val):
		end_point = val
		queue_redraw()

@export var total_value: float = 50.0  # Total length value (e.g., 100 cm)
@export var major_step: float = 10.0   # Label and tick interval (every 10 cm)
@export var tick_height: float = 12.0  # Height of the tick marks in pixels
@export var line_color: Color = Color.WHITE

func _draw() -> void:
	# 1. Draw the main baseline
	draw_line(start_point, end_point, line_color, 2.0)
	
	var total_distance = start_point.distance_to(end_point)
	if total_distance == 0 or total_value == 0:
		return
		
	var dir = (end_point - start_point).normalized()
	# Calculate a perpendicular vector to point the ticks downward/sideways
	var perp = Vector2(-dir.y, dir.x) 
	
	var num_steps = int(round(total_value / major_step))
	var font = ThemeDB.fallback_font
	var font_size = 12
	
	for i in range(num_steps + 1):
		var current_value = i * major_step
		var t = current_value / total_value
		var pos = start_point.lerp(end_point, t)
		
		# 2. Draw the tick mark
		var tick_end = pos + (perp * tick_height)
		draw_line(pos, tick_end, line_color, 1.5)
		
		# 3. Draw the text label ("0cm", "10cm", etc.)
		var text = str(int(current_value))
		var text_pos = tick_end + (perp * 14.0) # Offset slightly past the tick mark
		
		# Adjust horizontal offset so the text centers nicely under the tick
		text_pos += Vector2(-12, 10) 
		
		draw_string(font, text_pos, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, line_color)
