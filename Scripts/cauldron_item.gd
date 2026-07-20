extends Node3D

@onready var my_mesh: MeshInstance3D = $InventoryItem
@onready var my_outline: MeshInstance3D = $Outline
@onready var my_collision: CollisionShape3D = $Area3D/CollisionShape3D

const OUTLINE_MATERIAL = preload("uid://cicn0qfge6ung")

var holding = false
var manager

func _ready() -> void:
	my_collision.shape = my_mesh.mesh.create_convex_shape()
	
	my_outline.mesh = my_mesh.mesh
	my_outline.set_surface_override_material(0, OUTLINE_MATERIAL)
	
	manager = get_parent()


func _process(_delta: float) -> void:
	if CursorMananger.holding_item == self:
		my_outline.visible = true
	elif my_outline.visible:
		my_outline.visible = false


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if CursorMananger.holding_item != null:
			CursorMananger.holding_item = null
		
		if manager.holding_item != self:
			manager.holding_item = self
			holding = true
		else:
			manager.holding_item = null
		holding = false


func _on_area_3d_mouse_entered() -> void:
	my_outline.visible = true
	CursorMananger.set_cursor("point")


func _on_area_3d_mouse_exited() -> void:
	my_outline.visible = false
	CursorMananger.set_cursor("default")
