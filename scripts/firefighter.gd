extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D
@onready var health_bar: Node2D = $"Health Bar"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const GREEN_HEALTH_BAR = preload("res://sprites/GreenHealthBar.png")

var UP = Vector2(0, -1)
@export var GRAVITY : float = 1900
@export var MAXFALLSPEED : float = 750
@export var MAXSPEED : float = 240
@export var JUMPFORCE : float = 2200
@export var ACCEL : float = 60
@export var WATERJETFORCE: float = 100

var motion = Vector2()

var health = 10
var is_burning = false
var is_alive = true
var facing_right = true

func _ready():
	health_bar.health_bar.texture_progress = GREEN_HEALTH_BAR
	pass

func _physics_process(delta):
	if is_alive == true:
		motion.y += GRAVITY * delta
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		#if facing_right == true:
			#$Sprite2D.scale.x = 1
		#else:
			#$Sprite2D.scale.x = -1
		
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if Input.is_action_pressed("right"):
			motion.x = lerp(motion.x, MAXSPEED, 0.45)
			facing_right = true

		elif Input.is_action_pressed("left"):
			motion.x = lerp(motion.x, -MAXSPEED, 0.45)
			facing_right = false

		else:
			motion.x = lerp(motion.x, 0.0,0.75)

			
		if Input.is_action_pressed("shoot") and Global.water_level >= 0:
			var mouse_pos = get_global_mouse_position()
			var pos = position
			var shoot_dir = pos - mouse_pos
			var shoot_dir_normalized = shoot_dir.normalized()
			motion.x = lerp(motion.x, shoot_dir_normalized.x * WATERJETFORCE, 1)
			motion.y = lerp(motion.y, (shoot_dir_normalized.y * WATERJETFORCE) + (GRAVITY * delta), 1)
			run_water_timer(delta)
			
		
		if is_on_floor():
			if Input.is_action_pressed("up"):
				motion.y = lerp(motion.y, -JUMPFORCE, 0.3)
		
		set_velocity(motion)
		set_up_direction(UP)
		move_and_slide()
		motion = velocity
	burning(delta)
	dying()

func run_water_timer(delta) -> void:
	print(Global.water_level)
	Global.water_level -= 2 * delta

func burning(delta):
	if is_burning == true and health > 0:
		health -= delta * 2
		animation_player.play("flash")
	else:
		animation_player.play("RESET")

func dying():
	if health <= 0 and is_alive == true:
		is_burning = false
		is_alive = false
		animated_sprite_2d.play("burnt")
		health_bar.visible = false

func reset_firefighter():
	is_burning = false
	is_alive = true
	animated_sprite_2d.play("default")
	health_bar.visible = true
	health = 5

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('fires') and area.visible == true:
		print('burning')
		is_burning = true
	elif area.is_in_group('exits'):
		#SceneTransition.change_scene("res://scenes/test_scene_2.tscn")
		SceneTransition.change_scene(get_parent().next_scene)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group('fires'):
		print('not burning')
		is_burning = false
