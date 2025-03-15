extends Area2D

var velocity = Vector2(350, 0)

func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	
	if $Sprite2D.global_position.y > 500:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
