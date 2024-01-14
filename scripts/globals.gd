extends Node

var level = 0

func next_level():
	print("next level")
	level = (level + 1) % 1
	
	if level == 0:
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
