extends Control

const FIRE_SYMBOL = preload("res://sprites/fireSymbol.png")
@onready var hbox: HBoxContainer = $HBoxContainer
 
@onready var number_of_fires_currently = get_parent().get_parent().get_tree().get_nodes_in_group("fires").filter(func(fire): return fire.visible == true).size()

func _ready() -> void:
	var number_of_fires_to_add = number_of_fires_currently
	for i in number_of_fires_to_add:
		var fire = TextureRect.new()
		fire.stretch_mode = TextureRect.STRETCH_KEEP
		fire.texture = FIRE_SYMBOL
		hbox.add_child(fire)
	pass

func _physics_process(delta: float) -> void:
	if hbox.get_child_count() != number_of_fires_currently:
		if number_of_fires_currently < hbox.get_child_count():
			if hbox.get_child(0):
				hbox.get_child(0).queue_free()
		print(number_of_fires_currently)
	elif number_of_fires_currently > hbox.get_child_count():
		pass
	#if number_of_fires_currently != get_parent().get_parent().number_of_fires:
		#for i in number_of_fires_currently:
			#if hbox.get_child(0):
				#hbox.get_child(0).queue_free()
		#for i in number_of_fires_currently:
			#var fire = TextureRect.new()
			#fire.stretch_mode = TextureRect.STRETCH_KEEP
			#fire.texture = FIRE_SYMBOL
			#hbox.add_child(fire)
		#number_of_fires_currently = get_parent().get_parent().number_of_fires
	number_of_fires_currently = get_parent().get_parent().get_tree().get_nodes_in_group("fires").filter(func(fire): return fire.visible == true).size()
