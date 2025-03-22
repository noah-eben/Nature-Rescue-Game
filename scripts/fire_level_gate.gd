extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var water_collider: CollisionShape2D = $CollisionShape2D
@onready var player_collider: CollisionShape2D = $StaticBody2D/CollisionShape2D

@onready var start_position = position

func _physics_process(delta: float) -> void:
	pass

func open_gate():
	#water_collider.set_deferred('disabled', true)
	#player_collider.set_deferred('disabled', true)
	pass

func reset_fire():
	position = start_position
	#visible = true
	#collision_shape_2d.set_deferred('disabled', false)
	pass
