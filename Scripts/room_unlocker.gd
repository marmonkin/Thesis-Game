extends Node3D

@export var unlock_room: Node3D
@export var in_room: Node3D
@export var direction: String
@export var trigger: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger.unlock.connect(_on_unlock)


func _on_unlock():
	in_room.neighbour_rooms[direction] = unlock_room.room_id
	if in_room == RoomManager.current_room:
		RoomManager.arrow_container.direction_activate(in_room.neighbour_rooms)
