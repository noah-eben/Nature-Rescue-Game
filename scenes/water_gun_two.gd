extends Node2D

var DROPLET = preload("res://scenes/droplet_two.tscn")

@onready var raycast: RayCast2D = $RayCast2D
@onready var stream: Line2D = $RayCast2D/Line2D

func draw_water_stream(delta: float) -> void:
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		var cast_point = raycast.get_collision_point()
		stream.points[1] = cast_point

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
	if Input.is_action_just_pressed("shoot"):
		var droplet_instance = DROPLET.instantiate()
		get_tree().root.add_child(droplet_instance)
		droplet_instance.global_position = global_position
		droplet_instance.rotation = rotation
		
	draw_water_stream(delta)
