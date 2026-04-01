extends Node3D

@export var neighbour_rooms : Dictionary[String, PackedScene] = {
	"North": null,
	"South": null,
	"East": null,
	"West": null
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
