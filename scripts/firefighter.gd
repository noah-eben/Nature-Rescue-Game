extends CharacterBody2D

var UP = Vector2(0, -1)
var GRAVITY : float = 6500
var MAXFALLSPEED : float = 750
var MAXSPEED : float = 620
var JUMPFORCE : float = 1900
var ACCEL : float = 80

var motion = Vector2()

var facing_right = true

func _ready():
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
		#$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		motion.x = lerp(motion.x, -MAXSPEED, 0.45)
		facing_right = false
		#$AnimationPlayer.play("walk")
	else:
		motion.x = lerp(motion.x, 0.0,0.75)
		#$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_pressed("up"):
			motion.y = lerp(motion.y, -JUMPFORCE, 0.7)
	
	#if !is_on_floor():
		#if motion.y < 0 :
			#$AnimationPlayer.play("jump")
		#elif motion.y > 0:
			#$AnimationPlayer.play("fall")
		
	
	set_velocity(motion)
	set_up_direction(UP)
	move_and_slide()
	motion = velocity
