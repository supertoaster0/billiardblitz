extends RigidBody2D

@export var Player : RigidBody2D
var pellet = preload("res://Scenes/enemy_scenes/8_ballpellet.tscn")
const TOKEN_ID = "Enemy"
var state = "idle"
var Health = 5

func _ready() -> void:
	var tween = get_tree().create_tween()
	$Sprite2D.position.y = -position.y - 120
	tween.tween_property($Sprite2D, "position", Vector2(0, 0), 1.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	var shadowtween = get_tree().create_tween()
	$ShadowEllipse.scale = Vector2(0.1, 0.1)
	shadowtween.tween_property($ShadowEllipse, "scale", Vector2(3, 3), 0.6).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

func look_at_player():
	var direction := 0.0
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))
	return direction

func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player":
		lose_health(1)
		Game.hit_stop(0.1)
	if body.TOKEN_ID == "Enemy" and "ChainReaction" in Game.picked_upgrades:
		body.lose_health(1)
	print(body.TOKEN_ID)

func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	if Health <= 0:
		Sfx.play_sound("Die")
		get_parent().dead_enemies += 1
		queue_free()
	else:
		Sfx.play_sound("Hit")


func _on_timer_timeout() -> void:
	shoot()

func shoot():
	var bullet = pellet.instantiate()
	bullet.position = position
	bullet.direction = look_at_player()
	$"..".add_child(bullet)
