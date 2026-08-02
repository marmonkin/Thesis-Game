extends Node3D

@onready var cauldron_area: Area3D = $Cauldron/cauldron_area

@onready var water_mesh: MeshInstance3D = $Cauldron/MeshInstance3D
var water_material

var holding_item

var cauldron_contents: Array

var default_color = Color("686cff")

@export var color_red: Array[Node3D]
@export var color_green: Array[Node3D]
@export var color_blue: Array[Node3D]
@export var color_yellow: Array[Node3D]


func _ready() -> void:
	water_material = water_mesh.get_active_material(0)


func _process(_delta: float) -> void:
	if (holding_item):
		activate_cauldron(true)
	else:
		activate_cauldron(false)


func _on_cauldron_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if (holding_item):
			cauldron_contents.append(holding_item)
			holding_item = null
			
			CursorMananger.set_cursor("default")
			
			if cauldron_contents.size() == 3:
				finalize()


func finalize():
	var color = Color()
	
	if recipe_matches(color_red):
		color = Color(0.854, 0.0, 0.418, 1.0)
	
	if recipe_matches(color_green):
		color = Color(0.0, 0.553, 0.431, 1.0)
	
	if recipe_matches(color_blue):
		color = Color(0.152, 0.0, 0.672, 1.0)
	
	if recipe_matches(color_yellow):
		color = Color(0.753, 0.776, 0.0, 1.0)
	
	water_material.albedo_color = color
	cauldron_contents.clear()


func recipe_matches(recipe: Array) -> bool:
	var remaining = recipe.duplicate()
	
	for item in cauldron_contents:
		if remaining.has(item):
			remaining.erase(item)
		else:
			return false
	
	return remaining.is_empty()


func activate_cauldron(state: bool):
	cauldron_area.visible = state


func _on_cauldron_mouse_entered() -> void:
	if holding_item:
		CursorMananger.set_cursor("put_in")


func _on_cauldron_mouse_exited() -> void:
	if holding_item:
		CursorMananger.set_cursor("default")
