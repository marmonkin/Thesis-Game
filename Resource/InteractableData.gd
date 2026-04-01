extends Resource
class_name InteractableData

enum INTERACTION { PICKUP, USE, LOOK, MOVE }

@export var interaction_type: INTERACTION

@export var display_name: String = "Object"
@export var requires_item: String = ""
