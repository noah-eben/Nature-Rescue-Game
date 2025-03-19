extends Node2D

var DROPLET = preload("res://scenes/droplet_two.tscn")

@onready var raycast: RayCast2D = $RayCast2D
@onready var stream: Line2D = $RayCast2D/Line2D
@onready var particles: CPUParticles2D = $RayCast2D/Particles
@onready var beam_particles: CPUParticles2D = $RayCast2D/Particles2

func _ready() -> void:
	stream.points[1] = Vector2.ZERO

func draw_water_stream(delta: float) -> void:
	particles.position = stream.points[1]
	raycast.force_raycast_update()
	var cast_point = to_local(raycast.get_collision_point())
	beam_particles.position = stream.points[1] * 0.5
	beam_particles.emission_rect_extents.x = (stream.points[1] - stream.points[0]).length() * 0.5
	
	if raycast.is_colliding() and Input.is_action_pressed("shoot") and Global.water_level > 0:
		stream.points[1] = cast_point
		appear()
		particles.emitting = true
		beam_particles.emitting = true
	elif not raycast.is_colliding() and Input.is_action_pressed("shoot") and Global.water_level > 0:
		stream.points[1] = Vector2(400, 0)
		appear()
		particles.emitting = true
		beam_particles.emitting = true
	elif Input.is_action_just_released("shoot") or Global.water_level <= 0:
		disappear()
		particles.emitting = false
		beam_particles.emitting = false
		#stream.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
	draw_water_stream(delta)

# Make laser appear
func appear() -> void:
	var tween = create_tween()
	tween.tween_property(stream, 'width', 4.0, 0.3)

# Make laser disappear
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(stream, 'width', 0, 0.3)



#func shootBullets() -> void:
	#if Input.is_action_just_pressed("shoot"):
		#var droplet_instance = DROPLET.instantiate()
		#get_tree().root.add_child(droplet_instance)
		#droplet_instance.global_position = global_position
		#droplet_instance.rotation = rotation
