extends Node3D

@onready var bag: Node3D = $/root/Main/Control/InventoryView/SubViewport/Bag

const INVENTORY_ITEM = preload("uid://0h84whpyjw5u")

var inventory: Array[Node3D] = []


func add_to_inventory(item):
	var new_item = INVENTORY_ITEM.instantiate()
	inventory.append(new_item)
	bag.add_child(new_item)
	new_item.global_position = bag.global_position
	new_item.name = item.name
	
	var new_item_mesh = new_item.get_node("InventoryItem")
	new_item_mesh.mesh = item.mesh
	
	var new_item_collision = new_item.get_node("CollisionShape3D")
	new_item_collision.shape = item.mesh.create_convex_shape()

func remove_from_inventory(item):
	inventory.erase(item)
	item.queue_free()
