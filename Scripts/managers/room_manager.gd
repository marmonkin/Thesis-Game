# RoomManager.gd
extends Node

@export var starting_room_id: String = "base_room"   # ID of the first room

@onready var room_container = get_node("/root/Main/RoomContainer")
@onready var arrow_container = get_node("/root/Main/MoveArrows")
@onready var cam_anchor = get_node("/root/Main/Cam_anchor")

var rooms: Dictionary[String, Node] = {}

var current_room: Node3D = null
var current_room_id: String = ""


func _ready():
	var main = get_node("/root/Main")
	
	for room in main.get_tree().get_nodes_in_group("room"):
		rooms[room.room_id] = room
	
	if starting_room_id:
		switch_to_room(starting_room_id)


func switch_to_room(room_id: String):
	# Prevent switching to the same room
	if current_room_id == room_id:
		return
	
	# Move to the new room
	var new_room = rooms.get(room_id)
	if new_room:
		current_room = new_room
		current_room_id = room_id
		
		cam_anchor.move_to_room(new_room)
		arrow_container.direction_activate(new_room.neighbour_rooms)
	else:
		printerr("Room ID not found: ", room_id)
		return
