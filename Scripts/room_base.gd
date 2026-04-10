extends Node3D

@export var room_id = ""

@export var neighbour_rooms : Dictionary[String, String] = {
	"North": "",
	"South": "",
	"East": "",
	"West": ""
}

var active_room = false


func _ready() -> void:
	if room_id != "base_room":
		visible = false


func _on_visibility_changed() -> void:
	if visible:
		RoomManager.arrow_container.direction_activate(neighbour_rooms)
		
	process_mode = PROCESS_MODE_DISABLED if !visible else PROCESS_MODE_INHERIT
	active_room = visible
