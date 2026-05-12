extends Area3D

signal unlock

@export var data: InteractableData

var is_activated: bool = true


func _ready():
	InteractionManager.register_interactable(self)
	if not data.requires_item == null:
		is_activated = false


func _on_mouse_entered():
	CursorMananger.set_cursor("grab")


func _on_mouse_exited():
	CursorMananger.set_cursor("default")


func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		interact()


func interact():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/inspect_key.dialogue"), "start")
	get_parent_node_3d().queue_free()
	InventoryManager.add_to_inventory(data.display_name)
	CursorMananger.set_cursor("default")




func _exit_tree() -> void:
	InteractionManager.unregister_interactable(self)
