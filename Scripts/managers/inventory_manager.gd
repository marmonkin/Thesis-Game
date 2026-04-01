extends Node3D

var inventory: Array[String] = []


func add_to_inventory(item: String):
	inventory.append(item)
	print("Picked up " + item)


func remove_from_inventory(item: String) -> bool:
	if not inventory.has(item):
		print("Don't have " + item)
		return false
		#probably add a return or something that would tell the player what they need this item
	
	inventory.erase(item)
	return true
