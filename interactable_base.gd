extends Area3D
class_name Interactable

@export var data: InteractableData

var cursor_manager: CursorManager
var inter_manager: InteractableManager


func _ready():
	if not cursor_manager:
		cursor_manager = get_tree().get_first_node_in_group("cursor_manager")
	
	if not inter_manager:
		inter_manager = get_tree().get_first_node_in_group("interaction_manager")
	
	inter_manager.register_interactable(self)

func _on_mouse_entered():
	# Change cursor based on data
	var cursor_type
	match data.interaction_type:
		"pickup":
			cursor_type = "hover"
	cursor_manager.set_cursor(cursor_type)

func _on_mouse_exited():
	cursor_manager.set_cursor("default")

func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		interact()

func interact():
	print("Interacting with ", data.display_name)
	# Handle interaction based on data
	match data.interaction_type:
		"pickup":
			get_parent_node_3d().queue_free()
			cursor_manager.set_cursor("default")
		_:
			print("No interaction")


func _exit_tree() -> void:
	inter_manager.unregister_interactable(self)
