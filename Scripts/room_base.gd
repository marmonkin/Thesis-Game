extends Node3D

@export var room_id = ""

@export var neighbour_rooms : Dictionary[String, String] = {
	"North": "",
	"South": "",
	"East": "",
	"West": ""
}

var active_room = false

func _on_visibility_changed() -> void:
	RoomManager.arrow_container.direction_activate(neighbour_rooms)

func set_state(state: bool):
	visible = state
	active_room = state
