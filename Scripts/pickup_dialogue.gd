extends Node3D

@export var resource: DialogueResource


func interact():
	DialogueManager.show_example_dialogue_balloon(resource)
	queue_free()
