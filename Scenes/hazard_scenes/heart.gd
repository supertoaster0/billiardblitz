extends Area2D

var sine_timer := 0.0

func _ready() -> void:
	var tween = get_tree().create_tween()
	$Sprite2D.position.y = -position.y - 120
	tween.tween_property($Sprite2D, "position", Vector2(0, -15), 1.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var shadowtween = get_tree().create_tween()
	$Shadow.scale = Vector2(0.1, 0.1)
	shadowtween.tween_property($Shadow, "scale", Vector2(2, 2), 0.6).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)


func _process(delta: float) -> void:
	sine_timer += delta
	$Sprite2D.position.y = sin(sine_timer * 4) * 7 - 15



func _on_body_entered(body: Node2D) -> void:
	if body.TOKEN_ID == "Player":
		Game.HEALTH += 10
		Sfx.play_sound("Heal")
		queue_free()
