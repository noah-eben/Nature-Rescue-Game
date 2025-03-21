extends CharacterBody2D

var UP = Vector2(0, -1)
@export var GRAVITY : float = 1900
@export var MAXFALLSPEED : float = 750
@export var MAXSPEED : float = 240
@export var JUMPFORCE : float = 2200
@export var ACCEL : float = 60
@export var WATERJETFORCE: float = 100

var motion = Vector2()


var facing_right = true

func run_water_timer(delta) -> void:
	if Global.water_level >= 0:
		Global.water_level = lerp(Global.water_level, (Global.water_level - 2), delta * 2)

func _ready():
	#print(name)
	pass

func _physics_process(delta):
	motion.y += GRAVITY * delta
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		$Sprite2D.scale.x = 1
	else:
		$Sprite2D.scale.x = -1
	
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
		if position.y > 50:
			motion.y = lerp(motion.y, (shoot_dir_normalized.y * WATERJETFORCE) + (GRAVITY * delta), 1)
			run_water_timer(delta)
		
	
	#if is_on_floor():
		#if Input.is_action_pressed("up"):
			#motion.y = lerp(motion.y, -JUMPFORCE, 0.3)
	
	set_velocity(motion)
	set_up_direction(UP)
	move_and_slide()
	motion = velocity
	
