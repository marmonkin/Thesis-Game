extends Node3D

@onready var outline: MeshInstance3D = $Outline

const OUTLINE_MATERIAL = preload("uid://cicn0qfge6ung")

var holding = false

func _process(_delta: float) -> void:
	if CursorMananger.holding_item == self:
		outline.visible = true
	elif outline.visible:
		outline.visible = false


func init_outline(mesh):
	outline.mesh = mesh
	outline.set_surface_override_material(0, OUTLINE_MATERIAL)


func _on_area_3d_mouse_entered() -> void:
	outline.visible = true
	print("visible")


func _on_area_3d_mouse_exited() -> void:
	outline.visible = false
	print("not")
