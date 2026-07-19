extends Area3D

@export var zoom_in_size = 4.
@export var transition_dur = 1.

var default_cam_size
var zoomed_in = false
var main_cam

@onready var pcam: PhantomCamera3D = %PhantomCamera3D


func _on_input_event(camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !zoomed_in:
		main_cam = camera
		default_cam_size = camera.size
		
		zoomed_in = true
		RoomManager.lock_rot = true
		pcam.priority = 2
		
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(main_cam, "size", zoom_in_size, transition_dur)


func _input(event: InputEvent) -> void:
	if zoomed_in:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			pcam.priority = 0
			zoomed_in = false
			RoomManager.lock_rot = false
			
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(main_cam, "size", default_cam_size, transition_dur)
