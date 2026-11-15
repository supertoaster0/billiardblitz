extends Area2D

var direction := 0.0
const SPEED = 500

func _process(delta: float) -> void:
	rotation += delta*4
	var delta_x = cos(deg_to_rad(direction))
	var delta_y = sin(deg_to_rad(direction))

	position.x += delta_x * SPEED * delta
	position.y += delta_y * SPEED * delta
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.TOKEN_ID == "Player":
		Game.lose_health(10 + Game.DAMAGE_RECEIVE)
		queue_free()
