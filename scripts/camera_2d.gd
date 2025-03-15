extends Camera2D

@onready var player : CharacterBody2D = $"../Firefighter"
@export var speed = 5

func _ready() -> void:
	position = player.position

func _physics_process(delta: float) -> void:
	position = lerp(position, player.position, speed * delta)
