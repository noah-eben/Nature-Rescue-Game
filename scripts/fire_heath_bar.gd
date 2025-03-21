extends Node2D

@onready var health_bar: TextureProgressBar = $"Health Bar"

func _ready() -> void:
	#hide()
	if get_parent() and get_parent().get("fire_health"):
		health_bar.max_value = get_parent().fire_health

func _process(delta: float) -> void:
	global_rotation = 0
	update_healthbar(delta)

func update_healthbar(delta):
	#print(health_bar.value)
	#if health_bar.value == 0.0:
		#hide()
	health_bar.value = get_parent().fire_health
