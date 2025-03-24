extends TextureProgressBar

@onready var firefighter: CharacterBody2D = $"../../Firefighter"

func _physics_process(delta: float) -> void:
	value = firefighter.health
