extends TextureButton

@onready var texture_rect: TextureRect = $"../../TextureRect"


func _on_button_down() -> void:
	InteractionManager.eyes_closed = true
	texture_rect.visible = true


func _on_button_up() -> void:
	InteractionManager.eyes_closed = false
	texture_rect.visible = false
