# RoomManager.gd
extends Node

@export var starting_room_id: String = "base_room"

@onready var arrow_container
@onready var cam_anchor

var rooms: Dictionary[String, Node] = {}

var current_room: Node3D = null
var current_room_id: String = ""


func _ready():
	pass


func get_room(id : String) -> Node3D:
	return rooms.get(id)


func switch_to_room(room_id: String):
	# Move to the new room
	var new_room = rooms.get(room_id)
	if new_room:
		current_room.visible = false
		for room in current_room.same_room:
			room.visible = false
		
		new_room.visible = true
		for room in new_room.same_room:
			room.visible = true
		current_room = new_room
		current_room_id = room_id
		
		cam_anchor.move_to_room(new_room)
		arrow_container.direction_activate(new_room.neighbour_rooms)
	else:
		printerr("Room ID not found: ", room_id)
		return


func register_main(main):
	if main:
		for room in main.get_tree().get_nodes_in_group("room"):
			rooms[room.room_id] = room
		try_initialize()


func register_camera(cam):
	cam_anchor = cam
	try_initialize()


func register_arrows(arrows):
	arrow_container = arrows
	try_initialize()


func try_initialize():
	if not cam_anchor:
		return

	if not arrow_container:
		return

	if rooms.is_empty():
		return

	var room = get_room(starting_room_id)

	if room:
		current_room = room
		switch_to_room(starting_room_id)
	else:
		printerr("Couldn't find starting room!")
