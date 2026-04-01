extends Node
class_name InteractableManager

var interactables: Array[Interactable] = []
var interactions_enabled: bool = true


func register_interactable(interactable: Interactable):
	if not interactables.has(interactable):
		interactables.append(interactable)


func unregister_interactable(interactable: Interactable):
	interactables.erase(interactable)


func set_interactions_enabled(enabled: bool):
	interactions_enabled = enabled
	for i in interactables:
		i.process_mode = PROCESS_MODE_DISABLED if not enabled else PROCESS_MODE_INHERIT
