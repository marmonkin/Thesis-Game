extends GridContainer

var first_selected: Control = null

func _ready():
	var children = get_children()
	children.shuffle()
	
	for i in children.size():
		move_child(children[i], i)
	
	for child in get_children():
		child.pressed.connect(_on_image_pressed.bind(child))


func _on_image_pressed(button):
	if first_selected == null:
		first_selected = button
		button.self_modulate = Color(0.882, 0.88, 0.0, 1.0)
		return

	if button == first_selected:
		button.self_modulate = Color.WHITE
		first_selected = null
		return

	first_selected.self_modulate = Color.WHITE
	swap_children(first_selected, button)
	first_selected = null

func swap_children(a: Node, b: Node):
	var a_index = a.get_index()
	var b_index = b.get_index()

	move_child(a, b_index)
	move_child(b, a_index)
