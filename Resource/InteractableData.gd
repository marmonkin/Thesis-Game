extends Resource
class_name InteractableData

enum INTERACTION { PICKUP, USE, LOOK, MOVE }

@export var display_name: String = "Object"
@export var interaction_type: INTERACTION
@export var requires_item: String = ""
