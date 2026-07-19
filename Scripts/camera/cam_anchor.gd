extends Node3D

@export var rotation_speed = 1.
@export var move_speed = 5.
@export var rotation_deg = 45.

var target_rotation = .0
var move_target = self
var move_target_pos: Vector3

var lock_rot = false


@onready var pcam: PhantomCamera3D = $Camera3D

func _ready() -> void:
	RoomManager.register_camera(self)
	target_rotation = rotation.y
	


func _process(delta):
	var rot = pcam.get_third_person_rotation()
	
	rot.y = lerp_angle(
		rot.y,
		target_rotation,
		rotation_speed * delta
	)
	
	pcam.set_third_person_rotation(rot)
	
	global_position = lerp(global_position, move_target_pos, move_speed * delta)


func move_to_room(room: Node3D):
	move_target_pos = room.global_position + Vector3(0, 1.5, 0)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rot_left") and not lock_rot:
		target_rotation -= deg_to_rad(rotation_deg)
		
	if event.is_action_pressed("rot_right") and not lock_rot:
		target_rotation += deg_to_rad(rotation_deg)
