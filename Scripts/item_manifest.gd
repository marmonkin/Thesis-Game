extends Node3D

@export var item_to_manifest: PackedScene
@export var time_to_manifest = .0


var my_room
var manifest_progress = .0
var manifest_pending = false

var used = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	my_room = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if used:
		return
	
	if InteractionManager.eyes_closed and RoomManager.current_room == my_room and not manifest_pending:
		manifest_progress += delta
		print(manifest_progress)
	
	if manifest_progress >= time_to_manifest:
		manifest_pending = true
	
	if not InteractionManager.eyes_closed and manifest_pending:
		manifest()

func manifest():
	used = true
	
	var new_item = item_to_manifest.instantiate()
	get_parent().add_child(new_item)
