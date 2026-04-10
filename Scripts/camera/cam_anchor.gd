extends Node3D

@export var rotation_speed = 1.
@export var move_speed = 5.
@export var rotation_deg = 1

var target_rotation = .0
var move_target = self

func _process(delta):
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
	global_position = lerp(global_position, move_target.global_position, move_speed * delta)


func move_to_room(room: Node3D):
	move_target = room


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rot_left"):
		target_rotation -= deg_to_rad(rotation_deg)
	if event.is_action_pressed("rot_right"):
		target_rotation += deg_to_rad(rotation_deg)
