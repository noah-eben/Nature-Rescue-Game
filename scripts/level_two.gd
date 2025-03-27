extends Node2D

@onready var lava: TileMapLayer = $Lava
@onready var water: TileMapLayer = $Water

@onready var next_scene = "res://scenes/levels/level_three.tscn"

@onready var firefighter: CharacterBody2D = $Firefighter
@onready var start_position: Marker2D = $"Start Position"

@onready var fire_level_gate: Area2D = $"Fire Level Gate"
@onready var camera_2d: Camera2D = $Camera2D
@onready var time_to_leave = false
@onready var level_exit: Area2D = $"Level Exit"

@onready var fire_gui_two: Control = $"CanvasLayer/Fire GUI Two"
@onready var fires = get_tree().get_nodes_in_group("fires")
@onready var number_of_fires : int = fires.filter(fire_is_visible).size()
@onready var total_number_of_fires : int = fires.size()

func _ready() -> void:
	Global.water_level = Global.max_water_level
	level_exit.monitorable = false
	level_exit.visible = false
	firefighter.position = start_position.position
	pass

func fire_is_visible(fire):
	return fire.visible == true

func _physics_process(delta: float) -> void:
	number_of_fires = fires.filter(fire_is_visible).size()
	
	check_cells(delta)
	show_gate(delta)
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func show_gate(delta):
	if number_of_fires == 0 and time_to_leave == false:
		firefighter.process_mode = Node.PROCESS_MODE_DISABLED
		camera_2d.process_mode = Node.PROCESS_MODE_DISABLED
		var tween = create_tween()
		tween.tween_property(camera_2d, "position", fire_level_gate.position, 3.0)
		level_exit.visible = true
		level_exit.monitorable = true
		tween.tween_property(fire_level_gate, 'position', fire_level_gate.position + Vector2(0, 200), 1.0 )
		tween.tween_property(fire_level_gate, 'position', fire_level_gate.position + Vector2(200, 0), 0.5 )
		
		tween.tween_property(camera_2d, "position", firefighter.position, 3.0)
		
		tween.tween_property(camera_2d, "process_mode", Node.PROCESS_MODE_INHERIT, 0.2)
		tween.tween_property(firefighter, "process_mode", Node.PROCESS_MODE_INHERIT, 2.0)
		time_to_leave = true

func check_cells(delta):
	if lava:
		var current_cell = lava.local_to_map(firefighter.position - Vector2(0, 16))
		var data = lava.get_cell_tile_data(current_cell)
		if data:
			var tile = data.get_custom_data('type')
			if tile == 'lava':
				firefighter.health = 0
	if water:
		var current_cell = water.local_to_map(firefighter.position - Vector2(0, 16))
		var data = water.get_cell_tile_data(current_cell)
		if data:
			var tile = data.get_custom_data('type')
			if tile == 'water':
				Global.water_level = Global.max_water_level

func revive_player():
	fire_level_gate.reset_fire()
	Global.water_level = 100
	firefighter.reset_firefighter()
	
	for fire in fires:
		fire.reset_fire()
