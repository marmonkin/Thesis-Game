extends Node3D

@export var rotation_speed = 1.
@export var rotation_deg = 1

@onready var 	directions = {
		"North": %N,
		"South": %S,
		"East": %E,
		"West": %W
	}

var target_rotation = .0


func _process(delta):
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)


func direction_activate(rooms : Dictionary):
	for dir in directions:
		var target_id = rooms.get(dir, "")
		
		directions[dir].visible = target_id != ""
		directions[dir].set_meta("target_room", target_id)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rot_left"):
		target_rotation -= deg_to_rad(rotation_deg)
	if event.is_action_pressed("rot_right"):
		target_rotation += deg_to_rad(rotation_deg)
