extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$sprite.play("default")


func _on_body_entered(body):
	Globals.next_level()
