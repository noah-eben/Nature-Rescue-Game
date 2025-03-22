extends Camera2D

@onready var player : CharacterBody2D = $"../Firefighter"
@export var speed = 5
@onready var target

func _ready() -> void:
	target = player
	position = target.position

func _physics_process(delta: float) -> void:
	position = lerp(position, target.position, speed * delta)
