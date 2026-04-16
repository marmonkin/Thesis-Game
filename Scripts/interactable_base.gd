extends Area3D
class_name Interactable

signal unlock

@export var data: InteractableData

var is_activated: bool = true


func _ready():
	InteractionManager.register_interactable(self)
	if not data.requires_item == null:
		is_activated = false


func _on_mouse_entered():
	var cursor_type
	
	match data.interaction_type:
		0:
			cursor_type = "grab"
		1:
			cursor_type = "question"
		2:
			cursor_type = "exclamation"
		3:
			cursor_type = "move"
	
	CursorMananger.set_cursor(cursor_type)


func _on_mouse_exited():
	CursorMananger.set_cursor("default")


func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		interact()


func interact():
	match data.interaction_type:
		0:
			get_parent_node_3d().queue_free()
			InventoryManager.add_to_inventory(data.display_name)
			CursorMananger.set_cursor("default")
		1:
			if not is_activated:
				if InventoryManager.remove_from_inventory(data.requires_item):
					print("Used " + data.requires_item)
					is_activated = true
					emit_signal("unlock")
			else:
				print("Already used")
		3:
			RoomManager.switch_to_room(get_meta("target_room"))
		_:
			print("No interaction")


func _exit_tree() -> void:
	InteractionManager.unregister_interactable(self)
