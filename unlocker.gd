extends Node3D

@export var unlock_room: Node3D
@export var in_room: Node3D
@export var direction: String
@export var by_using: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	by_using.unlock.connect(_on_unlock)

func _on_unlock():
	in_room.neighbour_rooms[direction] = unlock_room.room_id
