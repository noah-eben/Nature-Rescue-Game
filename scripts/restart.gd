extends Control

func _process(delta: float) -> void:
	if get_parent():
		if get_parent().get_parent().firefighter.is_alive == true:
			hide()
		else:
			show()
