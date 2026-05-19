extends CSGCylinder3D

@export var my_id = 0

@export var sens = .4
@export var snap_speed = 8.

@export var min_drag_speed = 1.1
@export var max_drag_speed = 40.

@onready var audio_stream_player_3d: AudioStreamPlayer = $AudioStreamPlayer3D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const STEP_DEG = 90.

var snapping = false
var dragging = false

var current_deg = .0
var target_deg = .0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_deg = rotation_degrees.y
	target_deg = current_deg
	
	audio_stream_player_3d.volume_db = -400.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if snapping:
		current_deg = lerp_angle(deg_to_rad(current_deg),deg_to_rad(target_deg),snap_speed * delta)
		
		current_deg = rad_to_deg(current_deg)
		rotation_degrees.y = current_deg
		
		if abs(rotation_degrees.y - target_deg) < 0.5:
			rotation_degrees.y = target_deg
			current_deg = target_deg
			snapping = false


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			dragging = true
			snapping = false
			
			
			audio_stream_player_3d.play()
			var length = audio_stream_player_3d.stream.get_length()
			audio_stream_player_3d.seek(randf_range(0.0, length))


func _input(event: InputEvent) -> void:
	if dragging and event is InputEventMouseMotion and not get_parent().solved:
		if get_parent().rotation_direction == 0:
			current_deg += event.relative.x * sens
		if get_parent().rotation_direction == 1:
			current_deg -= event.relative.y * sens
		
		rotation_degrees.y = current_deg
		
		print(audio_stream_player_3d.playing)
		
		# drag speed
		var speed = abs(event.relative.x)
		
		# normalize speed
		var t = clamp(speed / max_drag_speed, 0.0, 1.0)
		
		# adjust sound based on speed
		#audio_stream_player_3d.pitch_scale = lerp(.9, 1.5, t)
		audio_stream_player_3d.volume_db = lerp(-15.0, -5.0, t)
		
		# stop if barely moving
		if speed < min_drag_speed:
			if audio_stream_player_3d.playing:
				audio_stream_player_3d.volume_db = lerp(-400.0, -5.0, t)
		else:
			# restart if moving again
			if !audio_stream_player_3d.playing:
				audio_stream_player_3d.play()
				var length = audio_stream_player_3d.stream.get_length()
				audio_stream_player_3d.seek(randf_range(0.0, length))
		
		
	if event is InputEventMouseButton and not get_parent().solved:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			if dragging:
				dragging = false
				
				snap()


func snap():
	target_deg = round(current_deg / STEP_DEG) * STEP_DEG
	snapping = true
	
	print(get_current_side())
	
	get_parent().reg_section(my_id, get_current_side())
	audio_stream_player.play()
	audio_stream_player_3d.stop()


func get_current_side() -> int:
	var normalized = fposmod(rotation_degrees.y, 360.0)
	var num = int(round(normalized / STEP_DEG)) % 4
	return num
