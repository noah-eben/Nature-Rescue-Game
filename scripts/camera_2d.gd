extends Camera2D

@onready var player : CharacterBody2D = $"../Firefighter"
@export var speed = 3
@onready var target

func _ready() -> void:
	target = player
	position = target.position

func _physics_process(delta: float) -> void:
	position = lerp(position, target.position, speed * delta)
	var mouse_pos = get_global_mouse_position()
	#drag_horizontal_offset = (mouse_pos.x - player.global_position.x) / (get_window().size.x / 3.0)
	#drag_vertical_offset = (mouse_pos.y - player.global_position.y) / (get_window().size.y / 3.0)
