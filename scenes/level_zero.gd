extends Node2D
class_name World

@onready var lava: TileMapLayer = $Lava
@onready var water: TileMapLayer = $Water

@onready var firefighter: CharacterBody2D = $Firefighter

func _physics_process(delta: float) -> void:
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
 
