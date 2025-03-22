extends Node2D
class_name World

@onready var lava: TileMapLayer = $Lava
@onready var water: TileMapLayer = $Water

@onready var firefighter: CharacterBody2D = $Firefighter
@onready var start_position: Marker2D = $"Start Position"

@onready var fire_gui: Control = $"CanvasLayer/Fire GUI"
@onready var fires = get_tree().get_nodes_in_group("fires")
@onready var number_of_fires = 0

func _ready() -> void:
	firefighter.position = start_position.position

func fire_is_visible(fire):
	return fire.visible == true

func _physics_process(delta: float) -> void:
	number_of_fires = fires.filter(fire_is_visible).size()
	fire_gui.get_node("Label").text = str("Fires left: ", number_of_fires)
	
	check_cells(delta)
	
	if Input.is_physical_key_pressed(KEY_R):
		revive_player()
 
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
				Global.water_level = 100

func revive_player():
	_ready()
	firefighter.reset_firefighter()
	
	for fire in fires:
		fire.reset_fire()
