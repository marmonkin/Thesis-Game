extends Resource
class_name InteractableData

@export var display_name: String = "Object"
@export var interaction_type: String = "default"   # e.g., "pickup", "use", "talk"
@export var action_text: String = "Interact"
@export var requires_item: String = ""             # optional required item name
@export var dialogue: String = ""                  # optional dialogue line
# Add any other properties you need (e.g., sound effect, animation, etc.)
