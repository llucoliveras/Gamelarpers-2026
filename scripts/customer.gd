extends Node2D

@export var target_size: Vector2i = Vector2(700, 700)
@onready var sprite_2d: Sprite2D = $Sprite2D

func change_sprite(texture: Texture2D) -> void:
	if not texture: return
	
	sprite_2d.texture = texture
	
	var texture_size: Vector2 = texture.get_size()
	var scale_factor: float = min(target_size.x / texture_size.x, target_size.y / texture_size.y)
	scale = Vector2(scale_factor, scale_factor)
