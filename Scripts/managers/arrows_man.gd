extends Node3D

@export var rotation_speed = 1.0
@export var rotation_deg = 1

var target_rotation = .0

var directions = {}

func _ready():
	directions = {
		"North": %N,
		"South": %S,
		"East": %E,
		"West": %W
	}

func direction_activate(rooms: Dictionary):
	if directions.is_empty():
		await ready
	for dir in directions:
		var target_id = rooms.get(dir, "")
		var arrow = directions[dir]
		arrow.visible = target_id != ""
		arrow.set_meta("target_room", target_id)
		arrow.process_mode = PROCESS_MODE_DISABLED if target_id == "" else PROCESS_MODE_INHERIT

func _process(delta):
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)

func _input(event):
	if event.is_action_pressed("rot_left"):
		target_rotation -= deg_to_rad(rotation_deg)
	if event.is_action_pressed("rot_right"):
		target_rotation += deg_to_rad(rotation_deg)
