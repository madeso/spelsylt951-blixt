extends Node

var level = 0

func next_level():
	print("next level")
	level = (level + 1) % 5
	
	if level == 0:
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
	if level == 1:
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
	if level == 2:
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
	if level == 3:
		get_tree().change_scene_to_file("res://levels/level_4.tscn")
	if level == 4:
		get_tree().change_scene_to_file("res://levels/level_5.tscn")
