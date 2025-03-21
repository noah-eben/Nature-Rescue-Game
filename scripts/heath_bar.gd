extends Node2D

@onready var health_bar: TextureProgressBar = $"Health Bar"

func _ready() -> void:
	if get_parent() and get_parent().get("health"):
		health_bar.max_value = get_parent().health

func _process(delta: float) -> void:
	global_rotation = 0
	update_healthbar(delta)

func update_healthbar(delta):
	health_bar.value = get_parent().health
