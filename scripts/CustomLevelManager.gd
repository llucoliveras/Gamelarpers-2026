class_name LevelManager
extends Node

const SCENE_TRANSITION = preload("uid://5qh6pynhc5ju")

func restart_level() -> void:
	get_tree().reload_current_scene()

func load_level(path: String) -> void:
	print("Trying")
	# 1. Safely load and check if the scene exists
	var scene_resource = ResourceLoader.load(path)
	if not scene_resource is PackedScene:
		push_error("LevelManager: Failed to load scene at path: " + path)
		return
	
	print("Trying 2")
	# 2. Clear old nodes (keeping SceneTransition)
	for node in get_tree().current_scene.get_children():
		if node.name in ["SceneTransition"]: 
			continue
		else: 
			node.queue_free()
	
	print(scene_resource)
	# 3. Instantiate and add the new scene
	get_tree().current_scene.add_child(scene_resource.instantiate())
	print("end")
