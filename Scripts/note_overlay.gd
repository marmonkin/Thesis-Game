extends Control

@onready var cam_anchor: Node3D = %Cam_anchor
@onready var move_arrows: Node3D = %MoveArrows

@onready var note_image: TextureRect = $AspectRatioContainer/TextureRect

@onready var note_container: AspectRatioContainer = $AspectRatioContainer
@onready var book_container: AspectRatioContainer = $Book


func activate_ui(img):
	note_image.texture = img
	visible = true
	note_container.visible = true
	
	cam_anchor.lock_rot = true
	move_arrows.lock_rot = true


func activate_book(res):
	book_container.visible = true


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		note_container.visible = false
		book_container.visible = false
		visible = false
		
		cam_anchor.lock_rot = false
		move_arrows.lock_rot = false
