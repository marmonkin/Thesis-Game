extends Node3D

@export var speed = .0

@export var init_rotation = .0

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D2

const STEP_DEG = 45.

var current_deg = .0
var target_deg = .0

var hold_time = 1

var holding = false
var hold_timer = 0.0
var did_half_turn = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_deg = mesh_instance_3d.rotation_degrees.y
	target_deg = init_rotation


func _process(delta):
	if holding:
		hold_timer += delta
	
		if hold_timer >= hold_time and !did_half_turn:
			target_deg += 45
			did_half_turn = true
			get_current_side()
	
	current_deg = lerp_angle(
		deg_to_rad(current_deg),
		deg_to_rad(target_deg),
		speed * delta
	)
	
	current_deg = rad_to_deg(current_deg)
	mesh_instance_3d.rotation_degrees.y = current_deg


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			holding = true
			hold_timer = 0.0
			did_half_turn = false
		else:
			holding = false
			if !did_half_turn:
				target_deg += 90
				get_current_side()


func get_current_side() -> int:
	var normalized = fposmod(target_deg, 360.0)
	var num = int(round(normalized / STEP_DEG)) % 8
	print(num)
	return num
