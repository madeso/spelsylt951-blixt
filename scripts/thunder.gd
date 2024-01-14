extends AnimatedSprite2D

func _ready():
	pass
	
func _process(delta):
	play("default")


func _on_thunder_body_entered(body):
	get_tree().reload_current_scene()
