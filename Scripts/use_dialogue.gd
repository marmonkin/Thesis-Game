extends Node3D

@export var resource: DialogueResource


func interact(state, item):
	DialogueManager.show_example_dialogue_balloon(resource, state, [self, { "item" = item }])
