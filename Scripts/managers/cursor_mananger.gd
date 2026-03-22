extends Node3D

# Preload cursor textures
@export var default_cursor: Texture2D
@export var hover_cursor: Texture2D
@export var interactable_cursor: Texture2D

func _ready():
	# Set the default cursor
	Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2.ZERO)

func set_cursor(cursor_type: String):
	match cursor_type:
		"default":
			Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2.ZERO)
		"hover":
			Input.set_custom_mouse_cursor(hover_cursor, Input.CURSOR_ARROW, Vector2.ZERO)
		"interactable":
			Input.set_custom_mouse_cursor(interactable_cursor, Input.CURSOR_ARROW, Vector2.ZERO)
