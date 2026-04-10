# RoomManager.gd
extends Node

@export var starting_room_id: String = "base_room"

@onready var arrow_container
@onready var cam_anchor

var rooms: Dictionary[String, Node] = {}

var current_room: Node3D = null
var current_room_id: String = ""


func _ready():
	var main = get_node("/root/Main")
	
	arrow_container = get_node("/root/Main/MoveArrows")
	cam_anchor = get_node("/root/Main/SubViewportContainer2/SubViewport/Cam_anchor")
	
	for room in main.get_tree().get_nodes_in_group("room"):
		rooms[room.room_id] = room
	
	if starting_room_id:
		current_room = get_room(starting_room_id)
		switch_to_room(starting_room_id)


func get_room(id : String) -> Node3D:
	return rooms[id]


func switch_to_room(room_id: String):
	# Move to the new room
	var new_room = rooms.get(room_id)
	if new_room:
		current_room.visible = false
		new_room.visible = true
		current_room = new_room
		current_room_id = room_id
		
		cam_anchor.move_to_room(new_room)
		arrow_container.direction_activate(new_room.neighbour_rooms)
	else:
		printerr("Room ID not found: ", room_id)
		return
