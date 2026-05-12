extends Control

@onready var cam_anchor: Node3D = %Cam_anchor
@onready var move_arrows: Node3D = %MoveArrows

func activate_ui():
	visible = true
	cam_anchor.lock_rot = true
	move_arrows.lock_rot = true


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		visible = false
		cam_anchor.lock_rot = false
		move_arrows.lock_rot = false
