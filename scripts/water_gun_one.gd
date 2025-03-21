extends Node2D

var droplet = preload("res://scenes/droplet.tscn")
@onready var line = $Line2D
@onready var muzzle = $"Sprite2D/Spawn Point"

var smoothed_mouse_pos: Vector2

var max_points = 250
var muzzle_velocity = 350
var gravity = 250

func mouse_follow(delta):
	smoothed_mouse_pos = lerp(smoothed_mouse_pos, get_global_mouse_position(), 0.3)
	$Sprite2D.look_at(smoothed_mouse_pos)

func update_trajectory(delta):
	line.clear_points()
	var pos = muzzle.global_position
	var vel = muzzle.global_transform.x * muzzle_velocity
	
	for i in max_points:
		line.add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
		if pos.y > 500:
			break

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var d = droplet.instantiate()
		add_child(d)
		d.transform = muzzle.global_transform
		d.velocity = d.transform.x * muzzle_velocity
		d.gravity = gravity
	
	update_trajectory(delta)
	mouse_follow(delta)

#func shootBullets() -> void:
	#if Input.is_action_just_pressed("shoot"):
		#var droplet_instance = DROPLET.instantiate()
		#get_tree().root.add_child(droplet_instance)
		#droplet_instance.global_position = global_position
		#droplet_instance.rotation = rotation
