extends Node3D

@export var my_image: Texture2D

var ui: Control


func _ready():
	ui = get_tree().current_scene.get_node("UI")
	InteractionManager.register_interactable(self)


func interact():
	ui.activate_ui(my_image)
