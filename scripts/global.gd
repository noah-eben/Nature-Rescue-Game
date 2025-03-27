extends Node

var water_level = 50
var is_alive = true
var max_water_level = 50

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
