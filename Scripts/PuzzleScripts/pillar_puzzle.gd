extends Node3D

@export var solution: Array[int]
@export var current_position: Array[int] = [0,0,0]

var solved = false

func reg_section(pos, num):
	current_position[pos] = num
	check_solved()


func check_solved():
	if current_position == solution:
		solved = true
