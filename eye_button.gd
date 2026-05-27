extends TextureButton

@onready var texture_rect: TextureRect = $"../../TextureRect"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	InteractionManager.eyes_closed = true
	texture_rect.visible = true


func _on_button_up() -> void:
	InteractionManager.eyes_closed = false
	texture_rect.visible = false
