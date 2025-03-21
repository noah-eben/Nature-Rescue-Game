extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var fire_health = 2.0

func _physics_process(delta: float) -> void:
	if fire_health <= 0.0:
		visible = false
		collision_shape_2d.set_deferred('disabled', true)

func reset_fire():
	fire_health = 2.0
	visible = true
	collision_shape_2d.set_deferred('disabled', false)
