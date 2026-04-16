extends Node3D
class_name CursorManager

# Preload cursor textures
@onready var default_cursor: Texture2D = preload("uid://brvuaqaf6q52a")
@onready var hover_cursor: Texture2D = preload("uid://fxx3nykk1kxw")
@onready var interactable_cursor: Texture2D = preload("uid://px2bdxrkhqr7")
@onready var move_cursor: Texture2D = preload("uid://dwlr5ykxomlkc")
@onready var look_cursor: Texture2D = preload("uid://rw80mx6ubi0d")
@onready var grab_cursor: Texture2D = preload("uid://cbtf4ncdgwi80")

func _ready():
	# Set the default cursor
	Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2(16, 16))


## default, question, exclamation, move
func set_cursor(cursor_type: String):
	match cursor_type:
		"default":
			Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		"question":
			Input.set_custom_mouse_cursor(hover_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		"exclamation":
			Input.set_custom_mouse_cursor(interactable_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		"move":
			Input.set_custom_mouse_cursor(move_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		"eye":
			Input.set_custom_mouse_cursor(look_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		"grab":
			Input.set_custom_mouse_cursor(grab_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
