extends Area3D

@export var my_resourse: Resource

var ui: Control

var is_activated: bool = true


func _ready():
	ui = get_tree().current_scene.get_node("UI")
	InteractionManager.register_interactable(self)


func _on_mouse_entered():
	CursorMananger.set_cursor("read")


func _on_mouse_exited():
	CursorMananger.set_cursor("default")


func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		interact()


func interact():
	ui.activate_book(my_resourse)


func _exit_tree() -> void:
	InteractionManager.unregister_interactable(self)
