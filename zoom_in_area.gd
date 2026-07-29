extends Area3D

@export var zoom_in_size = 4.
@export var transition_dur = 1.

var default_cam_size

var zoom_process = false
var zoomed_in = false
var main_cam

var manager

@onready var pcam: PhantomCamera3D = %PhantomCamera3D


func _ready() -> void:
	manager = get_parent()


func _on_input_event(camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !zoomed_in and !zoom_process:
		zoom_process = true
		
		main_cam = camera
		default_cam_size = camera.size
		
		RoomManager.lock_rot = true
		pcam.priority = 2
		
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(main_cam, "size", zoom_in_size, transition_dur)
		
		await tween.finished
		$CollisionShape3D.set_deferred("disabled", true)
		zoomed_in = true
		zoom_process = false


func _input(event: InputEvent) -> void:
	if zoomed_in:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and !zoom_process:
			zoom_process = true
			
			$CollisionShape3D.set_deferred("disabled", false)
			
			CursorMananger.set_cursor("default")
			
			manager.holding_item = null
			
			pcam.priority = 0
			RoomManager.lock_rot = false
			
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(main_cam, "size", default_cam_size, transition_dur)
			
			await tween.finished
			zoomed_in = false
			zoom_process = false
