extends CSGBox3D

@onready var window: Window = %Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func interact():
	window.show()
