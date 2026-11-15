extends RigidBody2D

@export var Player : RigidBody2D
const TOKEN_ID = "Enemy"
var state = "idle"
var direction = 0
var Health = 3

func _ready() -> void:
	var tween = get_tree().create_tween()
	$Graphic.position.y = -position.y - 120
	tween.tween_property($Graphic, "position", Vector2(0, 0), 1.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var shadowtween = get_tree().create_tween()
	$ShadowEllipse.scale = Vector2(0.1, 0.1)
	shadowtween.tween_property($ShadowEllipse, "scale", Vector2(2, 2), 0.6).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))
		
func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player":
		lose_health(Game.ATK_POWER)
		Game.hit_stop(0.1)
	elif body.TOKEN_ID == "Enemy":
		Sfx.play_sound("Heal")
		body.Health += 1
		Sfx.play_sound("Hit")

func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:$Graphic/HPCounter.text = str(Health)

func lose_health(damage):
	Health -= Game.ATK_POWER
	if Health <= 0:
		Sfx.play_sound("Die")
		get_parent().dead_enemies += 1
		queue_free()
	else:
		Sfx.play_sound("Hit")


func _on_initial_timer_timeout() -> void:
	pass
